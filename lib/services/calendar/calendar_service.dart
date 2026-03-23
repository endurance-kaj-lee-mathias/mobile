import 'package:dio/dio.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_models.dart';
import 'package:get/get.dart';

class CalendarService {
  CalendarService({Dio? client}) : _client = client ?? Get.find<Dio>();

  final Dio _client;

  Future<List<CalendarEventModel>> getAppointments() async {
    final response = await _client.get<List<dynamic>>('/calendar/appointments');
    final list = response.data ?? [];
    return list.cast<Map<String, dynamic>>().map(CalendarEventModel.fromJson).toList();
  }

  Future<List<SlotModel>> getSlots({
    required DateTime from,
    required DateTime to,
    String? providerId,
  }) async {
    final params = <String, dynamic>{
      'from': from.toUtc().toIso8601String(),
      'to': to.toUtc().toIso8601String(),
    };
    if (providerId != null) params['providerId'] = providerId;
    final response = await _client.get<List<dynamic>>(
      '/calendar/slots',
      queryParameters: params,
    );
    final list = response.data ?? [];
    return list.cast<Map<String, dynamic>>().map(SlotModel.fromJson).toList();
  }

  Future<void> bookSlot(String slotId) async {
    await _client.post<void>(
      '/calendar/slots/$slotId/book',
      data: {'urgent': false},
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> cancelAppointment(String id) async {
    await _client.patch<void>(
      '/calendar/appointments/$id/cancel',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> createSlot({
    required DateTime start,
    required DateTime end,
    required bool isUrgent,
    bool isRecurring = false,
  }) async {
    await _client.post<void>(
      '/calendar/slots',
      data: {
        'startTime': start.toUtc().toIso8601String(),
        'endTime': end.toUtc().toIso8601String(),
        'isUrgent': isUrgent,
        'isRecurring': isRecurring,
      },
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> deleteSlot(String id) async {
    await _client.delete<void>(
      '/calendar/slots/$id',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<void> deleteSlotSeries(String seriesId) async {
    await _client.delete<void>(
      '/calendar/slots/series/$seriesId',
      options: Options(responseType: ResponseType.plain),
    );
  }

  Future<List<CalendarEventModel>> getAppointmentsForDay(String day) async {
    final response = await _client.get<List<dynamic>>('/calendar/appointments/me/$day');
    final list = response.data ?? [];
    return list.cast<Map<String, dynamic>>().map(CalendarEventModel.fromJson).toList();
  }

  Future<SlotWithProviderModel?> getFirstAvailableSlot() async {
    final response = await _client.get<Map<String, dynamic>>('/calendar/slots/first-available');
    if (response.data == null) return null;
    return SlotWithProviderModel.fromJson(response.data!);
  }

  Future<SlotWithProviderModel> getSlotDetails(String slotId) async {
    final response = await _client.get<Map<String, dynamic>>('/calendar/slots/$slotId/details');
    return SlotWithProviderModel.fromJson(response.data!);
  }

  Future<List<int>> exportCalendar() async {
    final response = await _client.get<dynamic>(
      '/calendar/me/export',
      options: Options(responseType: ResponseType.bytes),
    );
    final data = response.data;
    if (data is List<int>) return data;
    if (data is List) return List<int>.from(data);
    return [];
  }
}
