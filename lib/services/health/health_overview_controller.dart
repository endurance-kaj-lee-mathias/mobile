import 'package:endurance_mobile_app/services/mood/mood_entry_model.dart';
import 'package:endurance_mobile_app/services/mood/mood_service.dart';
import 'package:endurance_mobile_app/services/stress/stress_score_model.dart';
import 'package:endurance_mobile_app/services/stress/stress_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class HealthOverviewController extends GetxController {
  HealthOverviewController({MoodService? moodService, StressService? stressService})
      : _moodService = moodService ?? MoodService(),
        _stressService = stressService ?? StressService();

  final MoodService _moodService;
  final StressService _stressService;

  final RxList<MoodEntryModel> moodEntries = <MoodEntryModel>[].obs;
  final RxList<StressScoreModel> stressScores = <StressScoreModel>[].obs;
  final RxBool isLoadingMood = false.obs;
  final RxBool isLoadingScores = false.obs;
  final RxBool isDeletingMood = false.obs;
  final RxBool isDeletingStress = false.obs;
  final RxInt stressTotal = 0.obs;

  Future<void> load() => Future.wait([_loadMoodEntries(), _loadStressScores()]);

  Future<void> _loadMoodEntries() async {
    isLoadingMood.value = true;
    try {
      moodEntries.assignAll(await _moodService.getWeekEntries());
    } catch (e) {
      debugPrint('HealthOverviewController._loadMoodEntries: $e');
    } finally {
      isLoadingMood.value = false;
    }
  }

  Future<void> _loadStressScores() async {
    isLoadingScores.value = true;
    try {
      final result = await _stressService.getScores(limit: 20, offset: 0);
      stressScores.assignAll(result.items);
      stressTotal.value = result.total;
    } catch (e) {
      debugPrint('HealthOverviewController._loadStressScores: $e');
    } finally {
      isLoadingScores.value = false;
    }
  }

  Future<bool> deleteEntry(String entryId) async {
    isDeletingMood.value = true;
    try {
      await _moodService.deleteEntry(entryId);
      moodEntries.removeWhere((e) => e.id == entryId);
      return true;
    } catch (e) {
      debugPrint('deleteEntry: $e');
      return false;
    } finally {
      isDeletingMood.value = false;
    }
  }

  Future<bool> deleteAllMood() async {
    isDeletingMood.value = true;
    try {
      await _moodService.deleteAllEntries();
      moodEntries.clear();
      return true;
    } catch (e) {
      debugPrint('deleteAllMood: $e');
      return false;
    } finally {
      isDeletingMood.value = false;
    }
  }

  Future<bool> deleteAllStress() async {
    isDeletingStress.value = true;
    try {
      await _stressService.deleteSamples();
      stressScores.clear();
      stressTotal.value = 0;
      return true;
    } catch (e) {
      debugPrint('deleteAllStress: $e');
      return false;
    } finally {
      isDeletingStress.value = false;
    }
  }
}
