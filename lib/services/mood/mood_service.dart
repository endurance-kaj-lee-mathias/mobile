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

  Future<List<MoodEntryModel>> getWeekEntries() async {
    final response = await _client.get<Map<String, dynamic>>('/mood/entries/me');
    final list = (response.data?['data'] as List<dynamic>?) ?? [];
    return list
        .cast<Map<String, dynamic>>()
        .map(MoodEntryModel.fromJson)
        .toList();
  }

  Future<({List<MoodEntryModel> entries, int totalWeeks})> getEntriesForWeek(
      int weekOffset) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/mood/entries/me',
      queryParameters: {'offset': weekOffset},
    );
    final list = (response.data?['data'] as List<dynamic>?) ?? [];
    final pagination =
        response.data?['pagination'] as Map<String, dynamic>? ?? {};
    return (
      entries: list
          .cast<Map<String, dynamic>>()
          .map(MoodEntryModel.fromJson)
          .toList(),
      totalWeeks: pagination['total_items'] as int? ?? 0,
    );
  }

  Future<List<MoodEntryModel>> getTwoRecentWeeksEntries() async {
    final results =
        await Future.wait([getEntriesForWeek(0), getEntriesForWeek(1)]);
    return [...results[0].entries, ...results[1].entries];
  }

  Future<void> deleteEntry(String entryId) async {
    await _client.delete<void>(
      '/mood/entries/$entryId',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> deleteAllEntries() async {
    await _client.delete<void>(
      '/mood/entries/me/all',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<MoodEntryModel?> getTodaysMoodEntry() async {
    final response = await _client.get<Map<String, dynamic>>('/mood/entries/me/today');
    if (response.data == null) return null;
    return MoodEntryModel.fromJson(response.data!);
  }
}
