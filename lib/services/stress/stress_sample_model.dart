class StressSampleModel {
  final String userId;
  final DateTime timestampUtc;
  final int windowMinutes;
  final double meanHr;
  final double rmssdMs;
  final double? restingHr;
  final int? steps;
  final double? sleepDebtHours;

  const StressSampleModel({
    required this.userId,
    required this.timestampUtc,
    required this.windowMinutes,
    required this.meanHr,
    required this.rmssdMs,
    this.restingHr,
    this.steps,
    this.sleepDebtHours,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'timestamp_utc': timestampUtc.toUtc().toIso8601String(),
    'window_minutes': windowMinutes,
    'mean_hr': meanHr,
    'rmssd_ms': rmssdMs,
    if (restingHr != null) 'resting_hr': restingHr,
    if (steps != null) 'steps': steps,
    if (sleepDebtHours != null) 'sleep_debt_hours': sleepDebtHours,
  };
}
