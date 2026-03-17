class CalendarEventModel {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  const CalendarEventModel({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }
}

class SlotModel {
  final String id;
  final String providerId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isUrgent;
  final bool isBooked;
  final String? seriesId;

  const SlotModel({
    required this.id,
    required this.providerId,
    required this.startTime,
    required this.endTime,
    required this.isUrgent,
    required this.isBooked,
    this.seriesId,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id']?.toString() ?? '',
      providerId: json['providerId']?.toString() ?? '',
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isUrgent: json['isUrgent'] as bool? ?? false,
      isBooked: json['isBooked'] as bool? ?? false,
      seriesId: json['seriesId']?.toString(),
    );
  }
}
