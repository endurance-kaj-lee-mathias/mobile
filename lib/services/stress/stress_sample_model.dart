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
    'userId': userId,
    'timestamp': timestampUtc.toUtc().toIso8601String(),
    'windowMinutes': windowMinutes,
    'meanHr': meanHr,
    'rmssdMs': rmssdMs,
    if (restingHr != null) 'restingHr': restingHr,
    if (steps != null) 'steps': steps,
    if (sleepDebtHours != null) 'sleepDebtHours': sleepDebtHours,
  };
}
