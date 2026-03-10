import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/mood/mood_entry_model.dart';
import 'package:get/get.dart';

class MoodService {
  MoodService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<void> submitEntry(MoodEntryModel entry) async {
    await _client.post<void>(
      '/mood/entries',
      data: entry.toJson(),
      options: Options(responseType: ResponseType.plain),
    );
  }

  /// Returns today's mood entry, or null if none has been submitted yet.
  Future<MoodEntryModel?> getTodayEntry() async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/mood/entries/me/today',
      );
      if (response.data == null) return null;
      return MoodEntryModel.fromJson(response.data!);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  /// Returns all mood entries for the current user.
  Future<List<MoodEntryModel>> getWeekEntries() async {
    final response = await _client.get<List<dynamic>>('/mood/entries/me');
    final list = response.data ?? [];
    return list
        .cast<Map<String, dynamic>>()
        .map(MoodEntryModel.fromJson)
        .toList();
  }
}
