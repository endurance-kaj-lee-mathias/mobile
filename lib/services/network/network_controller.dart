import 'dart:async';

import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/network/invite_model.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

enum NetworkInviteError { userNotFound, alreadyConnected, cannotSend, generic }

class NetworkController extends GetxController with WidgetsBindingObserver {
  NetworkController({NetworkService? service})
    : _service = service ?? NetworkService();

  final NetworkService _service;

  // ─── Polling intervals ────────────────────────────────────────────────────
  // Fast: used while the Network tab is open.
  static const _fastInterval = Duration(seconds: 15);
  // Slow: used while the app is in the foreground but the user is on another tab.
  // Only invites are polled at this rate (to keep the badge accurate).
  static const _slowInterval = Duration(seconds: 60);

  // ─── State ────────────────────────────────────────────────────────────────
  final RxList<MemberModel> members = <MemberModel>[].obs;
  final RxList<InviteModel> incoming = <InviteModel>[].obs;
  final RxList<InviteModel> outgoing = <InviteModel>[].obs;

  final RxBool isLoadingMembers = false.obs;
  final RxBool isLoadingInvites = false.obs;
  final RxBool isActing = false.obs;
  final RxBool isSending = false.obs;
  final Rxn<NetworkInviteError> sendError = Rxn<NetworkInviteError>();

  // ─── Grouped member views ─────────────────────────────────────────────────
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

  // ─── Lifecycle ────────────────────────────────────────────────────────────

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
          load(); // always do a full refresh when coming back from background
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

  // ─── Tab visibility ───────────────────────────────────────────────────────

  /// Called by [NetworkPage] when it becomes visible.
  /// Immediately refreshes both lists and switches to fast polling.
  void enterNetworkTab() {
    _isOnNetworkTab = true;
    load();
    _restartPolling();
  }

  /// Called by [NetworkPage] when it is navigated away from.
  /// Reverts to slow invites-only polling for the badge.
  void leaveNetworkTab() {
    _isOnNetworkTab = false;
    _restartPolling();
  }

  // ─── Polling internals ────────────────────────────────────────────────────

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

  /// Single poll tick with context-aware logic:
  ///
  /// - Always fetches invites (needed for the badge and the requests list).
  /// - Fetches connections **only** when on the Network tab **and** there are
  ///   outgoing requests — the only way connections can change without the user
  ///   doing it themselves is when someone accepts one of those requests.
  Future<void> _onPollTick() async {
    await loadInvites();
    if (_isOnNetworkTab && outgoing.isNotEmpty) {
      await loadMembers();
    }
  }

  // ─── Push notifications ───────────────────────────────────────────────────

  /// Called by [NotificationController] when a push notification signals a
  /// network event. Does a full refresh so the badge and lists update instantly.
  void handlePushNotification() => load();

  // ─── Data loading ─────────────────────────────────────────────────────────

  Future<void> load() => Future.wait([loadMembers(), loadInvites()]);

  Future<void> loadMembers() async {
    // Only show the loading spinner on the initial fetch (empty list).
    // Background polls update data silently to avoid UI flicker.
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
    // Same: only show spinner when there is nothing to display yet.
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

  // ─── Mutations ────────────────────────────────────────────────────────────

  /// Removes [supportId] from the current user's network.
  ///
  /// Throws [NetworkRemoveNotAllowedError] when the backend returns an error
  /// because the authenticated user is the *supporter* rather than the veteran
  /// — a known backend limitation. All other failures rethrow as-is.
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
      // Adding a new outgoing request means connections may start changing —
      // restart polling so the connections poller kicks in if on the tab.
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
      await loadMembers();
      return true;
    } catch (e) {
      debugPrint('Failed to accept invite: $e');
      return false;
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
}

/// Thrown by [NetworkController.removeMember] when the backend rejects the
/// deletion because the relationship direction is not supported by the current
/// API (the authenticated user is the supporter, not the veteran).
class NetworkRemoveNotAllowedError implements Exception {
  const NetworkRemoveNotAllowedError();
}

