class CalendarEventModel {
  final String id;
  final String? slotId;
  final String? veteranId;
  final String? title;
  final String status;
  final bool urgent;
  final DateTime startTime;
  final DateTime endTime;
  final String? providerUsername;
  final String? providerImage;
  final String? providerFirstName;
  final String? providerLastName;

  const CalendarEventModel({
    required this.id,
    this.slotId,
    this.veteranId,
    this.title,
    this.status = 'scheduled',
    this.urgent = false,
    required this.startTime,
    required this.endTime,
    this.providerUsername,
    this.providerImage,
    this.providerFirstName,
    this.providerLastName,
  });

  factory CalendarEventModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventModel(
      id: json['id']?.toString() ?? '',
      slotId: json['slotId']?.toString(),
      veteranId: json['veteranId']?.toString(),
      title: json['title']?.toString(),
      status: json['status']?.toString() ?? 'scheduled',
      urgent: json['urgent'] as bool? ?? false,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      providerUsername: json['providerUsername']?.toString(),
      providerImage: json['providerImage']?.toString(),
      providerFirstName: json['providerFirstName']?.toString(),
      providerLastName: json['providerLastName']?.toString(),
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

class SlotWithProviderModel {
  final String id;
  final String providerId;
  final String? providerUsername;
  final String? providerImage;
  final String? providerFirstName;
  final String? providerLastName;
  final DateTime startTime;
  final DateTime endTime;
  final bool isUrgent;
  final bool isBooked;
  final String? seriesId;
  final String? title;

  const SlotWithProviderModel({
    required this.id,
    required this.providerId,
    this.providerUsername,
    this.providerImage,
    this.providerFirstName,
    this.providerLastName,
    required this.startTime,
    required this.endTime,
    required this.isUrgent,
    required this.isBooked,
    this.seriesId,
    this.title,
  });

  factory SlotWithProviderModel.fromJson(Map<String, dynamic> json) {
    return SlotWithProviderModel(
      id: json['id']?.toString() ?? '',
      providerId: json['providerId']?.toString() ?? '',
      providerUsername: json['providerUsername']?.toString(),
      providerImage: json['providerImage']?.toString(),
      providerFirstName: json['providerFirstName']?.toString(),
      providerLastName: json['providerLastName']?.toString(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      isUrgent: json['isUrgent'] as bool? ?? false,
      isBooked: json['isBooked'] as bool? ?? false,
      seriesId: json['seriesId']?.toString(),
      title: json['title']?.toString(),
    );
  }
}
