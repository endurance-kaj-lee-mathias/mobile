import 'dart:io';

import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
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
  final nextAppointment = Rxn<CalendarEventModel>();

  @override
  void onInit() {
    super.onInit();
    final auth = Get.find<AuthController>();
    ever(auth.isAuthenticated, (bool authenticated) {
      if (authenticated) {
        loadAppointments();
      } else {
        appointments.clear();
        mySlots.clear();
        _updateNextAppointment();
      }
    });
    if (auth.isAuthenticated.value) loadAppointments();
  }

  void _updateNextAppointment() {
    final now = DateTime.now();
    final upcoming = appointments
        .where((a) => a.startTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
    nextAppointment.value = upcoming.isEmpty ? null : upcoming.first;
  }

  final mySlots = <SlotModel>[].obs;
  final isLoadingAppointments = false.obs;
  final isLoadingMySlots = false.obs;

  Future<void> loadAppointments() async {
    isLoadingAppointments.value = true;
    try {
      final list = await _service.getAppointments();
      appointments.assignAll(list);
      _updateNextAppointment();
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

  Future<void> bookSlot(String slotId, {bool isUrgent = false}) async {
    await _service.bookSlot(slotId, isUrgent: isUrgent);
    await loadAppointments();
  }

  Future<SlotModel?> getFirstAvailableUrgentSlot() async {
    final now = DateTime.now();
    final slots = await _service.getSlots(
      from: now,
      to: now.add(const Duration(days: 30)),
    );
    final urgent = slots
        .where((s) => s.isUrgent && !s.isBooked)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
    return urgent.isEmpty ? null : urgent.first;
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
