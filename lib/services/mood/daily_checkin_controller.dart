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

  /// Mood score from today's submission (0–10), null if not done.
  final Rxn<int> todayScore = Rxn<int>();

  /// True while the initial today-status check is in progress.
  final RxBool isLoadingStatus = false.obs;

  /// Whether health permissions have been granted.
  final RxBool hasHealthPermission = false.obs;

  /// True while a submission is in progress.
  final RxBool isSubmitting = false.obs;

  /// Non-null if the last submission failed.
  final Rxn<String> submitError = Rxn<String>();

  /// Mood entries for the past 7 days. Empty while loading.
  final RxList<MoodEntryModel> weekEntries = <MoodEntryModel>[].obs;

  /// True while the weekly history is being fetched.
  final RxBool isLoadingHistory = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkHealthPermission();
  }

  /// Fetches today's check-in status and the weekly history from the backend.
  /// Call this when the home screen becomes visible.
  Future<void> load() async {
    await Future.wait([_checkTodayStatus(), _loadWeekEntries()]);
  }

  Future<void> _checkTodayStatus() async {
    isLoadingStatus.value = true;
    try {
      // Prefer the authoritative backend state over local storage.
      final entry = await _moodService.getTodayEntry();
      if (entry != null) {
        hasDoneToday.value = true;
        todayScore.value = entry.moodScore;
        // Keep local cache in sync for offline resilience.
        await _storage.write(key: _lastSubmitKey, value: entry.date);
        await _storage.write(
          key: _lastScoreKey,
          value: entry.moodScore.toString(),
        );
        return;
      }
      // No entry on the backend today – clear any stale local cache.
      hasDoneToday.value = false;
      todayScore.value = null;
    } catch (e) {
      debugPrint('DailyCheckInController._checkTodayStatus error: $e');
      // Fall back to local storage when the network is unavailable.
      final stored = await _storage.read(key: _lastSubmitKey);
      final today = _todayString();
      if (stored == today) {
        hasDoneToday.value = true;
        final scoreStr = await _storage.read(key: _lastScoreKey);
        todayScore.value = scoreStr != null ? int.tryParse(scoreStr) : null;
      }
    } finally {
      isLoadingStatus.value = false;
    }
  }

  Future<void> _loadWeekEntries() async {
    isLoadingHistory.value = true;
    try {
      final entries = await _moodService.getWeekEntries();
      weekEntries.assignAll(entries);
    } catch (e) {
      debugPrint('DailyCheckInController._loadWeekEntries error: $e');
    } finally {
      isLoadingHistory.value = false;
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

      // Refresh the weekly history to include the new/updated entry.
      _loadWeekEntries().ignore();

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
