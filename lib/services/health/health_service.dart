import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

class HealthSnapshot {
  final double? meanHr;
  final double? hrvMs;
  final double? restingHr;
  final int? steps;
  final double? sleepDebtHours;
  final DateTime windowStart;
  final DateTime windowEnd;

  const HealthSnapshot({
    this.meanHr,
    this.hrvMs,
    this.restingHr,
    this.steps,
    this.sleepDebtHours,
    required this.windowStart,
    required this.windowEnd,
  });

  bool get canSubmitStress => meanHr != null && hrvMs != null;

  int get windowMinutes =>
      windowEnd.difference(windowStart).inMinutes.clamp(1, 1440 * 7);
}

class HealthService {
  static final _typesAndroid = [
    HealthDataType.HEART_RATE,
    HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_SESSION,
  ];

  static final _typesIOS = [
    HealthDataType.HEART_RATE,
    HealthDataType.HEART_RATE_VARIABILITY_SDNN,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_REM,
    HealthDataType.SLEEP_LIGHT,
  ];

  static List<HealthDataType> get _types =>
      Platform.isIOS ? _typesIOS : _typesAndroid;

  final _health = Health();

  Future<bool> requestPermissions() async {
    try {
      if (Platform.isAndroid && !(await _health.isHealthConnectAvailable())) {
        await _health.installHealthConnect();
        return false;
      }
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

  Future<bool> hasPermissions() async {
    try {
      if (Platform.isAndroid && !(await _health.isHealthConnectAvailable())) {
        return false;
      }
      final result = await _health.hasPermissions(_types);
      return result == true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> hasOrRequestPermissions() async {
    try {
      if (Platform.isAndroid && !(await _health.isHealthConnectAvailable())) {
        return false;
      }
      final result = await _health.hasPermissions(_types);
      if (result != null) return result;
      return await _health.requestAuthorization(
        _types,
        permissions: List.filled(_types.length, HealthDataAccess.READ),
      );
    } catch (e) {
      debugPrint('HealthService.hasOrRequestPermissions error: $e');
      return false;
    }
  }

  Future<HealthSnapshot?> readSnapshot({DateTime? since}) async {
    final end = DateTime.now();
    final cap = end.subtract(const Duration(hours: 72));
    final start = (since != null && since.isAfter(cap)) ? since : cap;

    try {
      final points = await _health.getHealthDataFromTypes(
        startTime: start,
        endTime: end,
        types: _types,
      );

      final hrPoints = points
          .where((p) => p.type == HealthDataType.HEART_RATE)
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();
      final double? meanHr = hrPoints.isEmpty
          ? null
          : hrPoints.reduce((a, b) => a + b) / hrPoints.length;

      final hrvType = Platform.isIOS
          ? HealthDataType.HEART_RATE_VARIABILITY_SDNN
          : HealthDataType.HEART_RATE_VARIABILITY_RMSSD;
      final hrvPoints = points
          .where((p) => p.type == hrvType)
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();
      final double? hrvMs = hrvPoints.isEmpty ? null : hrvPoints.last;

      final restingPoints = points
          .where((p) => p.type == HealthDataType.RESTING_HEART_RATE)
          .map((p) => (p.value as NumericHealthValue).numericValue.toDouble())
          .toList();
      final double? restingHr = restingPoints.isEmpty
          ? null
          : restingPoints.last;

      final stepPoints = points
          .where((p) => p.type == HealthDataType.STEPS)
          .map((p) => (p.value as NumericHealthValue).numericValue.toInt())
          .toList();
      final int? steps = stepPoints.isEmpty
          ? null
          : stepPoints.reduce((a, b) => a + b);

      final sleepTypes = Platform.isIOS
          ? {
              HealthDataType.SLEEP_ASLEEP,
              HealthDataType.SLEEP_DEEP,
              HealthDataType.SLEEP_REM,
              HealthDataType.SLEEP_LIGHT,
            }
          : {HealthDataType.SLEEP_SESSION};
      final sleepSeconds = points
          .where((p) => sleepTypes.contains(p.type))
          .map((p) => p.dateTo.difference(p.dateFrom).inSeconds)
          .fold<int>(0, (sum, s) => sum + s);
      final double? sleepDebt = sleepSeconds == 0
          ? null
          : (8.0 - sleepSeconds / 3600.0).clamp(0.0, 24.0);

      return HealthSnapshot(
        meanHr: meanHr,
        hrvMs: hrvMs,
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

