import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/stress/stress_sample_model.dart';
import 'package:endurance_mobile_app/services/stress/stress_score_model.dart';
import 'package:get/get.dart';

class StressService {
  StressService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<void> ingestSample(StressSampleModel sample) async {
    await _client.post<void>(
      '/stress/samples',
      data: sample.toJson(),
      options: Options(responseType: ResponseType.plain),
    );
  }

  /// Returns the timestamp of the most recently submitted stress sample,
  /// or null if none exists (404 = no samples yet).
  Future<DateTime?> getLatestSampleTimestamp() async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/stress/samples/latest',
      );
      final ts = response.data?['timestamp'] as String?;
      return ts != null ? DateTime.parse(ts) : null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  Future<({List<StressScoreModel> items, int total})> getScores({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/stress/scores/latest',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    final data = response.data!;
    final items = (data['items'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(StressScoreModel.fromJson)
        .toList();
    return (items: items, total: data['total'] as int);
  }

  Future<void> deleteSamples() async {
    await _client.delete<void>(
      '/stress/samples/me',
      options: Options(responseType: ResponseType.plain),
    );
  }
}
