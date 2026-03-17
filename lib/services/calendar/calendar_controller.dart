import 'dart:io';

import 'package:endurance_mobile_app/services/calendar/calendar_models.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_service.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CalendarController extends GetxController {
  CalendarController({CalendarService? service})
      : _service = service ?? CalendarService();

  final CalendarService _service;

  final appointments = <CalendarEventModel>[].obs;
  final mySlots = <SlotModel>[].obs;
  final isLoadingAppointments = false.obs;
  final isLoadingMySlots = false.obs;

  CalendarEventModel? get nextAppointment {
    final now = DateTime.now();
    final upcoming = appointments.where((a) => a.startTime.isAfter(now)).toList();
    if (upcoming.isEmpty) return null;
    upcoming.sort((a, b) => a.startTime.compareTo(b.startTime));
    return upcoming.first;
  }

  Future<void> loadAppointments() async {
    isLoadingAppointments.value = true;
    try {
      final list = await _service.getAppointments();
      appointments.assignAll(list);
    } catch (e) {
      debugPrint('CalendarController.loadAppointments error: $e');
    } finally {
      isLoadingAppointments.value = false;
    }
  }

  Future<void> loadMySlots() async {
    isLoadingMySlots.value = true;
    try {
      final userId = Get.find<UserController>().user.value?.id;
      if (userId == null) return;
      final now = DateTime.now();
      final list = await _service.getSlots(
        from: now,
        to: now.add(const Duration(days: 90)),
        providerId: userId,
      );
      mySlots.assignAll(list);
    } catch (e) {
      debugPrint('CalendarController.loadMySlots error: $e');
    } finally {
      isLoadingMySlots.value = false;
    }
  }

  Future<void> cancelAppointment(String id) async {
    await _service.cancelAppointment(id);
    await loadAppointments();
  }

  Future<void> bookSlot(String slotId) async {
    await _service.bookSlot(slotId);
    await loadAppointments();
  }

  Future<void> createSlot({
    required DateTime start,
    required DateTime end,
    required bool isUrgent,
    bool isRecurring = false,
  }) async {
    await _service.createSlot(
      start: start,
      end: end,
      isUrgent: isUrgent,
      isRecurring: isRecurring,
    );
    await loadMySlots();
  }

  Future<void> deleteSlot(String id) async {
    await _service.deleteSlot(id);
    await loadMySlots();
  }

  Future<void> deleteSlotSeries(String seriesId) async {
    await _service.deleteSlotSeries(seriesId);
    await loadMySlots();
  }

  Future<void> exportCalendar() async {
    final bytes = await _service.exportCalendar();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/calendar.ics');
    await file.writeAsBytes(bytes);
    await Share.shareXFiles([XFile(file.path)], text: 'Calendar export');
  }
}
