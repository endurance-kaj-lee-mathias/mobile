import 'dart:async';

import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/network/invite_model.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_service.dart';
import 'package:endurance_mobile_app/services/network/privacy_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum NetworkInviteError { userNotFound, alreadyConnected, cannotSend, generic }

class NetworkController extends GetxController with WidgetsBindingObserver {
  NetworkController({NetworkService? service})
    : _service = service ?? NetworkService();

  final NetworkService _service;

  static const _fastInterval = Duration(seconds: 15);
  static const _slowInterval = Duration(seconds: 60);

  final RxList<MemberModel> members = <MemberModel>[].obs;
  final RxList<InviteModel> incoming = <InviteModel>[].obs;
  final RxList<InviteModel> outgoing = <InviteModel>[].obs;
  final RxMap<String, List<SharingRuleModel>> sharingRulesByViewer =
      <String, List<SharingRuleModel>>{}.obs;
  final RxList<ResourcePrivacyModel> resourcePrivacy =
      <ResourcePrivacyModel>[].obs;

  final RxBool isLoadingMembers = false.obs;
  final RxBool isLoadingInvites = false.obs;
  final RxBool isLoadingSharingRules = false.obs;
  final RxBool isActing = false.obs;
  final RxBool isSending = false.obs;
  final Rxn<NetworkInviteError> sendError = Rxn<NetworkInviteError>();

  List<MemberModel> get supportMembers =>
      members.where((m) => m.role == MemberRole.support).toList();
  List<MemberModel> get therapistMembers =>
      members.where((m) => m.role == MemberRole.therapist).toList();
  List<MemberModel> get veteranMembers =>
      members.where((m) => m.role == MemberRole.veteran).toList();
  List<MemberModel> get unknownMembers =>
      members.where((m) => m.role == MemberRole.unknown).toList();

  Timer? _pollTimer;
  bool _isOnNetworkTab = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    final auth = Get.find<AuthController>();
    ever(auth.isAuthenticated, (bool authenticated) {
      if (authenticated) {
        load();
        _restartPolling();
      } else {
        _stopPolling();
        members.clear();
        incoming.clear();
        outgoing.clear();
        sharingRulesByViewer.clear();
        resourcePrivacy.clear();
      }
    });

    if (auth.isAuthenticated.value) {
      load();
      _restartPolling();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopPolling();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isAuthenticated = Get.find<AuthController>().isAuthenticated.value;
    switch (state) {
      case AppLifecycleState.resumed:
        if (isAuthenticated) {
          load();
          _restartPolling();
        }
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _stopPolling();
      default:
        break;
    }
  }

  void enterNetworkTab() {
    _isOnNetworkTab = true;
    load();
    _restartPolling();
  }

  void leaveNetworkTab() {
    _isOnNetworkTab = false;
    _restartPolling();
  }

  void _restartPolling() {
    _pollTimer?.cancel();
    final isAuthenticated = Get.find<AuthController>().isAuthenticated.value;
    if (!isAuthenticated) return;

    final interval = _isOnNetworkTab ? _fastInterval : _slowInterval;
    _pollTimer = Timer.periodic(interval, (_) => _onPollTick());
  }

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> _onPollTick() async {
    await loadInvites();
    if (_isOnNetworkTab && outgoing.isNotEmpty) {
      await loadMembers();
    }
    await loadSharingRules();
  }

  void handlePushNotification() => load();

  Future<void> load() => Future.wait(
      [loadMembers(), loadInvites(), loadSharingRules(), loadResourcePrivacy()]);

  Future<void> loadMembers() async {
    if (members.isEmpty) isLoadingMembers.value = true;
    try {
      members.value = await _service.getMembers();
    } catch (e) {
      debugPrint('Failed to load network members: $e');
    } finally {
      isLoadingMembers.value = false;
    }
  }

  Future<void> loadInvites() async {
    if (incoming.isEmpty && outgoing.isEmpty) isLoadingInvites.value = true;
    try {
      final result = await _service.listInvites();
      incoming.value = result.incoming;
      outgoing.value = result.outgoing;
    } catch (e) {
      debugPrint('Failed to load invites: $e');
    } finally {
      isLoadingInvites.value = false;
    }
  }

  Future<void> removeMember(String supportId) async {
    isActing.value = true;
    try {
      await _service.removeMember(supportId);
      members.removeWhere((m) => m.id == supportId);
    } on DioException catch (e) {
      debugPrint('Failed to remove member (${e.response?.statusCode}): $e');
      throw const NetworkRemoveNotAllowedError();
    } finally {
      isActing.value = false;
    }
  }

  Future<bool> sendInvite(String username, {String? note}) async {
    sendError.value = null;
    isSending.value = true;
    try {
      final invite = await _service.sendInvite(username, note: note);
      outgoing.add(invite);
      _restartPolling();
      return true;
    } on DioException catch (e) {
      sendError.value = switch (e.response?.statusCode) {
        404 => NetworkInviteError.userNotFound,
        409 => NetworkInviteError.alreadyConnected,
        403 => NetworkInviteError.cannotSend,
        _ => NetworkInviteError.generic,
      };
      return false;
    } catch (_) {
      sendError.value = NetworkInviteError.generic;
      return false;
    } finally {
      isSending.value = false;
    }
  }

  Future<bool> acceptInvite(String inviteId) async {
    isActing.value = true;
    try {
      await _service.acceptInvite(inviteId);
      incoming.removeWhere((i) => i.id == inviteId);
      loadMembers();
      return true;
    } catch (e) {
      debugPrint('Failed to accept invite: $e');
      // Backend occasionally returns 5xx after a successful commit.
      // Reload to determine actual state: if the invite is gone, it worked.
      await Future.wait([loadMembers(), loadInvites()]);
      return incoming.every((i) => i.id != inviteId);
    } finally {
      isActing.value = false;
    }
  }

  Future<bool> declineInvite(String inviteId) async {
    isActing.value = true;
    try {
      await _service.declineInvite(inviteId);
      incoming.removeWhere((i) => i.id == inviteId);
      return true;
    } catch (e) {
      debugPrint('Failed to decline invite: $e');
      return false;
    } finally {
      isActing.value = false;
    }
  }

  Future<void> loadResourcePrivacy() async {
    try {
      final loaded = await _service.getResourcePrivacy();
      final defaults = {
        for (final r in SharingResource.values) r.value: false,
      };
      for (final m in loaded) {
        defaults[m.resource] = m.isPrivate;
      }
      resourcePrivacy.value = defaults.entries
          .map((e) => ResourcePrivacyModel(resource: e.key, isPrivate: e.value))
          .toList();
    } catch (e) {
      debugPrint('Failed to load resource privacy: $e');
    }
  }

  Future<void> loadSharingRules() async {
    try {
      final rules = await _service.getSharingRules();
      final byViewer = <String, List<SharingRuleModel>>{};
      for (final rule in rules) {
        byViewer.putIfAbsent(rule.viewerId, () => []).add(rule);
      }
      sharingRulesByViewer.value = byViewer;
    } catch (e) {
      debugPrint('Failed to load sharing rules: $e');
    } finally {
      isLoadingSharingRules.value = false;
    }
  }

  Future<bool> updateSharingRule(
    String viewerId,
    SharingResource resource,
    SharingEffect effect,
  ) async {
    try {
      await _service.createSharingRule(viewerId, resource, effect);
      await loadSharingRules();
      return true;
    } catch (e) {
      debugPrint('Failed to update sharing rule: $e');
      return false;
    }
  }

  Future<bool> removeSharingRule(String ruleId) async {
    try {
      await _service.deleteSharingRule(ruleId);
      await loadSharingRules();
      return true;
    } catch (e) {
      debugPrint('Failed to remove sharing rule: $e');
      return false;
    }
  }

  Future<bool> updateResourcePrivacy(String resource, {required bool isPrivate}) async {
    try {
      await _service.setResourcePrivacy(resource, isPrivate: isPrivate);
      await loadResourcePrivacy();
      return true;
    } catch (e) {
      debugPrint('Failed to update resource privacy: $e');
      return false;
    }
  }

  List<SharingRuleModel> getRulesForViewer(String viewerId) =>
      sharingRulesByViewer[viewerId] ?? [];
}

class NetworkRemoveNotAllowedError implements Exception {
  const NetworkRemoveNotAllowedError();
}

