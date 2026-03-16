import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/network/invite_model.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/privacy_model.dart';
import 'package:get/get.dart';

class NetworkService {
  NetworkService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<List<MemberModel>> getMembers() async {
    final response = await _client.get<List<dynamic>>('/users/support');
    return (response.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(MemberModel.fromJson)
        .toList();
  }

  Future<void> removeMember(String supportId) async {
    await _client.delete<void>(
      '/users/support/$supportId',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<InviteModel> sendInvite(String username, {String? note}) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/support/',
      data: {
        'username': username,
        if (note != null && note.isNotEmpty) 'note': note,
      },
    );
    return InviteModel.fromJson(response.data!);
  }

  Future<void> acceptInvite(String inviteId) async {
    await _client.patch<void>(
      '/support/$inviteId/accept',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> declineInvite(String inviteId) async {
    await _client.patch<void>(
      '/support/$inviteId/decline',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<InviteListModel> listInvites() async {
    final response = await _client.get<Map<String, dynamic>>('/support/');
    return InviteListModel.fromJson(response.data!);
  }

  Future<List<SharingRuleModel>> getSharingRules() async {
    final response = await _client.get<List<dynamic>>('/sharing/rules');
    return (response.data ?? [])
        .cast<Map<String, dynamic>>()
        .map(SharingRuleModel.fromJson)
        .toList();
  }

  Future<SharingRuleModel> createSharingRule(
    String viewerId,
    SharingResource resource,
    SharingEffect effect,
  ) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/sharing/rules',
      data: {
        'viewerId': viewerId,
        'resource': resource.value,
        'effect': effect.value,
      },
    );
    return SharingRuleModel.fromJson(response.data!);
  }

  Future<void> deleteSharingRule(String ruleId) async {
    await _client.delete<void>(
      '/sharing/rules/$ruleId',
      options: Options(responseType: ResponseType.plain),
    );
  }
}
