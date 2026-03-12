import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/stress/stress_sample_model.dart';
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
}
