class MoodEntryModel {
  final String date;
  final int moodScore;
  final String? notes;

  const MoodEntryModel({
    required this.date,
    required this.moodScore,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'moodScore': moodScore,
    if (notes != null) 'notes': notes,
  };
}
