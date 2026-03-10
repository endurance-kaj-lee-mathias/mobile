import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

/// Aggregated health metrics for the past 24 hours.
class HealthSnapshot {
  final double? meanHr;
  final double? rmssdMs;
  final double? restingHr;
  final int? steps;
  final double? sleepDebtHours;
  final DateTime windowStart;
  final DateTime windowEnd;

  const HealthSnapshot({
    this.meanHr,
    this.rmssdMs,
    this.restingHr,
    this.steps,
    this.sleepDebtHours,
    required this.windowStart,
    required this.windowEnd,
  });

  /// True when required stress fields are present (needed to POST /stress/samples).
  bool get canSubmitStress => meanHr != null && rmssdMs != null;

  int get windowMinutes =>
      windowEnd.difference(windowStart).inMinutes.clamp(1, 1440 * 7);
}

class HealthService {
  static final _types = [
    HealthDataType.HEART_RATE,
    HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_SESSION,
  ];

  final _health = Health();

  /// Requests health permissions. Returns true if at least read-access for
  /// HEART_RATE and STEPS was granted.
  Future<bool> requestPermissions() async {
    try {
      final granted = await _health.requestAuthorization(
        _types,
        permissions: List.filled(_types.length, HealthDataAccess.READ),
      );
      return granted;
    } catch (e) {
      debugPrint('HealthService.requestPermissions error: $e');
      return false;
    }
  }

  /// Returns true if health permissions are already granted.
  Future<bool> hasPermissions() async {
    try {
      final result = await _health.hasPermissions(_types);
      return result == true;
    } catch (_) {
      return false;
    }
  }

  /// Reads a 24-hour health snapshot ending now.
  Future<HealthSnapshot?> readSnapshot() async {
    final end = DateTime.now();
    final start = end.subtract(const Duration(hours: 24));

    try {
      final points = await _health.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: _types,
      );

      // Mean HR
      final hrPoints = points
          .where((p) => p.type == HealthDataType.HEART_RATE)
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();
      final double? meanHr = hrPoints.isEmpty
          ? null
          : hrPoints.reduce((a, b) => a + b) / hrPoints.length;

      // RMSSD — take the most recent sample
      final rmssdPoints = points
          .where((p) => p.type == HealthDataType.HEART_RATE_VARIABILITY_RMSSD)
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();
      final double? rmssdMs = rmssdPoints.isEmpty ? null : rmssdPoints.last;

      // Resting HR — take the most recent sample
      final restingPoints = points
          .where((p) => p.type == HealthDataType.RESTING_HEART_RATE)
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();
      final double? restingHr = restingPoints.isEmpty
          ? null
          : restingPoints.last;

      // Steps — sum all samples
      final stepPoints = points
          .where((p) => p.type == HealthDataType.STEPS)
          .map((p) => (p.value as NumericHealthValue).numericValue.toInt())
          .toList();
      final int? steps = stepPoints.isEmpty
          ? null
          : stepPoints.reduce((a, b) => a + b);

      // Sleep debt: recommended 8h minus total sleep in window
      final sleepSeconds = points
          .where((p) => p.type == HealthDataType.SLEEP_SESSION)
          .map((p) => p.dateTo.difference(p.dateFrom).inSeconds)
          .fold<int>(0, (sum, s) => sum + s);
      final double? sleepDebt = sleepSeconds == 0
          ? null
          : (8.0 - sleepSeconds / 3600.0).clamp(0.0, 24.0);

      return HealthSnapshot(
        meanHr: meanHr,
        rmssdMs: rmssdMs,
        restingHr: restingHr,
        steps: steps,
        sleepDebtHours: sleepDebt,
        windowStart: start,
        windowEnd: end,
      );
    } catch (e) {
      debugPrint('HealthService.readSnapshot error: $e');
      return null;
    }
  }
}
