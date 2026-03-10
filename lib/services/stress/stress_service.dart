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
}
