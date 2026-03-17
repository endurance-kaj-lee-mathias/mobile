import 'dart:async';

import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/health/health_service.dart';
import 'package:endurance_mobile_app/services/mood/mood_entry_model.dart';
import 'package:endurance_mobile_app/services/mood/mood_service.dart';
import 'package:endurance_mobile_app/services/stress/stress_sample_model.dart';
import 'package:endurance_mobile_app/services/stress/stress_service.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyCheckInController extends GetxController {
  DailyCheckInController({
    MoodService? moodService,
    StressService? stressService,
    HealthService? healthService,
  }) : _moodService = moodService ?? MoodService(),
       _stressService = stressService ?? StressService(),
       _healthService = healthService ?? HealthService();

  final MoodService _moodService;
  final StressService _stressService;
  final HealthService _healthService;

  Timer? _clockTimer;

  final RxInt clockTick = 0.obs;
  final RxBool isLoading = false.obs;
  final RxBool hasHealthPermission = false.obs;
  final RxBool includeHealthData = false.obs;
  final RxBool isSubmitting = false.obs;
  final Rxn<String> submitError = Rxn<String>();

  final RxList<MoodEntryModel> weekEntries = <MoodEntryModel>[].obs;

  List<MoodEntryModel> get todayEntries {
    final today = _todayString();
    final entries = weekEntries.where((e) => e.date == today).toList();
    entries.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });
    return entries;
  }

  bool get hasDoneToday => todayEntries.isNotEmpty;

  MoodEntryModel? get lastTodayEntry =>
      todayEntries.isNotEmpty ? todayEntries.first : null;

  double? get avgTodayScore {
    final entries = todayEntries;
    if (entries.isEmpty) return null;
    return entries.fold<int>(0, (acc, e) => acc + e.moodScore) / entries.length;
  }

  @override
  void onInit() {
    super.onInit();
    _checkHealthPermission();
    _clockTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      clockTick.value++;
    });
    final auth = Get.find<AuthController>();
    ever(auth.isAuthenticated, (bool authenticated) {
      if (!authenticated) weekEntries.clear();
    });
  }

  @override
  void onClose() {
    _clockTimer?.cancel();
    super.onClose();
  }

  Future<void> load() async {
    await _checkHealthPermissionOnVisible();
    return _loadWeekEntries();
  }

  Future<void> _checkHealthPermissionOnVisible() async {
    final granted = await _healthService.hasOrRequestPermissions();
    hasHealthPermission.value = granted;
    includeHealthData.value = granted;
  }

  Future<void> _loadWeekEntries() async {
    isLoading.value = true;
    try {
      final entries = await _moodService.getWeekEntries();
      weekEntries.assignAll(entries);
    } catch (e) {
      debugPrint('DailyCheckInController._loadWeekEntries error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _checkHealthPermission() async {
    final granted = await _healthService.hasPermissions();
    hasHealthPermission.value = granted;
    includeHealthData.value = granted;
  }

  Future<bool> requestHealthPermission() async {
    final granted = await _healthService.requestPermissions();
    hasHealthPermission.value = granted;
    if (granted) includeHealthData.value = true;
    return granted;
  }

  Future<bool> submit({required int moodScore, String? notes}) async {
    isSubmitting.value = true;
    submitError.value = null;

    try {
      await _moodService.submitEntry(
        MoodEntryModel(id: '', date: _todayString(), moodScore: moodScore, notes: notes),
      );

      _loadWeekEntries().ignore();

      if (includeHealthData.value && hasHealthPermission.value) {
        _submitHealthSample().ignore();
      }

      return true;
    } catch (e) {
      debugPrint('DailyCheckInController.submit error: $e');
      submitError.value = e.toString();
      return false;
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> _submitHealthSample() async {
    if (!hasHealthPermission.value) {
      debugPrint('_submitHealthSample: skipped — no health permission');
      return;
    }

    final userId = Get.find<UserController>().user.value?.id;
    if (userId == null || userId.isEmpty) {
      debugPrint('_submitHealthSample: skipped — no userId');
      return;
    }

    // Use the backend's last submitted sample as the window start so we never
    // overlap data that was already sent, regardless of check-in history.
    final since = await _stressService.getLatestSampleTimestamp();
    debugPrint('_submitHealthSample: using since=$since');

    final snapshot = await _healthService.readSnapshot(since: since);
    debugPrint(
      '_submitHealthSample: snapshot=$snapshot '
      'meanHr=${snapshot?.meanHr} hrv=${snapshot?.hrvMs} '
      'steps=${snapshot?.steps} canSubmit=${snapshot?.canSubmitStress}',
    );
    if (snapshot == null || !snapshot.canSubmitStress) return;

    try {
      await _stressService.ingestSample(
        StressSampleModel(
          userId: userId,
          timestampUtc: snapshot.windowEnd.toUtc(),
          windowMinutes: snapshot.windowMinutes,
          meanHr: snapshot.meanHr!,
          rmssdMs: snapshot.hrvMs!,
          restingHr: snapshot.restingHr,
          steps: snapshot.steps,
          sleepDebtHours: snapshot.sleepDebtHours,
        ),
      );
      debugPrint('_submitHealthSample: stress sample posted successfully');
    } catch (e) {
      debugPrint('DailyCheckInController._submitHealthSample error: $e');
    }
  }

  static String _todayString() =>
      DateFormat('yyyy-MM-dd').format(DateTime.now());
}
