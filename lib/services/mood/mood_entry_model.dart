class MoodEntryModel {
  final String date;
  final int moodScore;
  final String? notes;
  final DateTime? createdAt;

  const MoodEntryModel({
    required this.date,
    required this.moodScore,
    this.notes,
    this.createdAt,
  });

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) => MoodEntryModel(
    date: json['date'] as String,
    moodScore: (json['moodScore'] as int).clamp(0, 10),
    notes: json['notes'] as String?,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'moodScore': moodScore,
    if (notes != null) 'notes': notes,
  };
}
