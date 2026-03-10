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

  /// True while entries are being fetched from the backend.
  final RxBool isLoading = false.obs;

  /// Whether health permissions have been granted.
  final RxBool hasHealthPermission = false.obs;

  /// True while a submission is in progress.
  final RxBool isSubmitting = false.obs;

  /// Non-null if the last submission failed.
  final Rxn<String> submitError = Rxn<String>();

  /// All mood entries for the current user, most-recent first.
  final RxList<MoodEntryModel> weekEntries = <MoodEntryModel>[].obs;

  // ---------------------------------------------------------------------------
  // Derived state — reading these inside Obx() reacts to weekEntries changes.
  // ---------------------------------------------------------------------------

  /// All entries submitted today, sorted newest-first.
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

  /// Whether at least one check-in has been submitted today.
  bool get hasDoneToday => todayEntries.isNotEmpty;

  /// The most-recently submitted entry for today, or null if none.
  MoodEntryModel? get lastTodayEntry =>
      todayEntries.isNotEmpty ? todayEntries.first : null;

  /// Average mood score across all of today's entries, or null if none.
  double? get avgTodayScore {
    final entries = todayEntries;
    if (entries.isEmpty) return null;
    return entries.fold<int>(0, (acc, e) => acc + e.moodScore) / entries.length;
  }

  @override
  void onInit() {
    super.onInit();
    _checkHealthPermission();
  }

  /// Fetches all mood entries from the backend.
  /// Call this when the home screen becomes visible.
  Future<void> load() => _loadWeekEntries();

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
    hasHealthPermission.value = await _healthService.hasPermissions();
  }

  /// Requests health permissions from the OS. Returns true when granted.
  Future<bool> requestHealthPermission() async {
    final granted = await _healthService.requestPermissions();
    hasHealthPermission.value = granted;
    return granted;
  }

  /// Submits a new check-in entry. Multiple submissions per day are allowed.
  Future<bool> submit({required int moodScore, String? notes}) async {
    isSubmitting.value = true;
    submitError.value = null;

    try {
      await _moodService.submitEntry(
        MoodEntryModel(date: _todayString(), moodScore: moodScore, notes: notes),
      );

      // Refresh so derived getters (todayEntries, hasDoneToday, …) update.
      _loadWeekEntries().ignore();

      // Attempt to attach health data (best-effort, never blocks submission).
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
