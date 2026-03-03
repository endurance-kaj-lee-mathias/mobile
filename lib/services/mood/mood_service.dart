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
}
