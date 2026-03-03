import 'package:endurance_mobile_app/services/health/health_service.dart';
import 'package:endurance_mobile_app/services/mood/mood_entry_model.dart';
import 'package:endurance_mobile_app/services/mood/mood_service.dart';
import 'package:endurance_mobile_app/services/stress/stress_sample_model.dart';
import 'package:endurance_mobile_app/services/stress/stress_service.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final _storage = const FlutterSecureStorage();

  static const _lastSubmitKey = 'daily_checkin_last_date';
  static const _lastScoreKey = 'daily_checkin_last_score';

  /// Whether the user has submitted today's check-in.
  final RxBool hasDoneToday = false.obs;

  /// Mood score from the last submission today (1–10), null if not done.
  final Rxn<int> todayScore = Rxn<int>();

  /// Whether health permissions have been granted.
  final RxBool hasHealthPermission = false.obs;

  /// True while a submission is in progress.
  final RxBool isSubmitting = false.obs;

  /// Non-null if the last submission failed.
  final Rxn<String> submitError = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    _checkTodayStatus();
    _checkHealthPermission();
  }

  Future<void> _checkTodayStatus() async {
    final stored = await _storage.read(key: _lastSubmitKey);
    final today = _todayString();
    if (stored == today) {
      hasDoneToday.value = true;
      final scoreStr = await _storage.read(key: _lastScoreKey);
      todayScore.value = scoreStr != null ? int.tryParse(scoreStr) : null;
    }
  }

  Future<void> _checkHealthPermission() async {
    hasHealthPermission.value = await _healthService.hasPermissions();
  }

  /// Requests health permissions from the OS. Returns true when granted.
  Future<bool> requestHealthPermission() async {
    final granted = await _healthService.requestPermissions();
    hasHealthPermission.value = granted;
    return granted;
  }

  /// Submits the daily check-in. Optionally also sends a health/stress sample.
  Future<bool> submit({required int moodScore, String? notes}) async {
    isSubmitting.value = true;
    submitError.value = null;

    try {
      final today = _todayString();
      await _moodService.submitEntry(
        MoodEntryModel(date: today, moodScore: moodScore, notes: notes),
      );

      // Persist locally so we know it's been done today
      await _storage.write(key: _lastSubmitKey, value: today);
      await _storage.write(key: _lastScoreKey, value: moodScore.toString());
      hasDoneToday.value = true;
      todayScore.value = moodScore;

      // Attempt to attach health data (best-effort, never blocks submission)
      _submitHealthSample().ignore();

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
    if (!hasHealthPermission.value) return;

    final userId = Get.find<UserController>().user.value?.id;
    if (userId == null || userId.isEmpty) return;

    final snapshot = await _healthService.readSnapshot();
    if (snapshot == null || !snapshot.canSubmitStress) return;

    try {
      await _stressService.ingestSample(
        StressSampleModel(
          userId: userId,
          timestampUtc: snapshot.windowEnd.toUtc(),
          windowMinutes: snapshot.windowMinutes,
          meanHr: snapshot.meanHr!,
          rmssdMs: snapshot.rmssdMs!,
          restingHr: snapshot.restingHr,
          steps: snapshot.steps,
          sleepDebtHours: snapshot.sleepDebtHours,
        ),
      );
    } catch (e) {
      debugPrint('DailyCheckInController._submitHealthSample error: $e');
    }
  }

  static String _todayString() =>
      DateFormat('yyyy-MM-dd').format(DateTime.now());
}
