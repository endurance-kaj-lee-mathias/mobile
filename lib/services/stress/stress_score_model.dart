class StressScoreModel {
  final String id;
  final double score;
  final String category;
  final String modelVersion;
  final DateTime computedAt;

  const StressScoreModel({
    required this.id,
    required this.score,
    required this.category,
    required this.modelVersion,
    required this.computedAt,
  });

  factory StressScoreModel.fromJson(Map<String, dynamic> json) => StressScoreModel(
    id: json['id'] as String,
    score: (json['score'] as num).toDouble(),
    category: json['category'] as String,
    modelVersion: json['modelVersion'] as String,
    computedAt: DateTime.parse(json['computedAt'] as String),
  );
}
