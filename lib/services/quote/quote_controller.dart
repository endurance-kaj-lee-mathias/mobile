import 'package:endurance_mobile_app/services/quote/quote_model.dart';
import 'package:endurance_mobile_app/services/quote/quote_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class QuoteController extends GetxController {
  QuoteController({QuoteService? service})
    : _service = service ?? QuoteService();

  final QuoteService _service;

  final Rxn<QuoteModel> quote = Rxn<QuoteModel>();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetch();
  }

  Future<void> _fetch() async {
    isLoading.value = true;
    try {
      quote.value = await _service.getRandom();
    } catch (e) {
      debugPrint('Failed to load quote: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
