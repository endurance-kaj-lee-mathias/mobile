class MoodEntryModel {
  final String date;
  final int moodScore;
  final String? notes;

  const MoodEntryModel({
    required this.date,
    required this.moodScore,
    this.notes,
  });

  factory MoodEntryModel.fromJson(Map<String, dynamic> json) => MoodEntryModel(
    date: json['date'] as String,
    moodScore: json['moodScore'] as int,
    notes: json['notes'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'moodScore': moodScore,
    if (notes != null) 'notes': notes,
  };
}
