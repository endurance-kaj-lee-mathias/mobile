import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/quote/quote_model.dart';

class QuoteService {
  QuoteService({Dio? client})
    : _client = client ?? Dio(BaseOptions(baseUrl: 'https://zenquotes.io'));

  final Dio _client;

  Future<QuoteModel> getRandom() async {
    final response = await _client.get<List<dynamic>>('/api/random');
    final data = response.data;
    if (data == null || data.isEmpty) throw Exception('Empty response');
    return QuoteModel.fromJson(data.first as Map<String, dynamic>);
  }
}
