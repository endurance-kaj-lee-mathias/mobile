enum SharingResource {
  userProfile,
  stressScores,
  moodEntries,
  calendar,
}

enum SharingEffect {
  allow,
  deny,
}

extension SharingResourceExt on SharingResource {
  String get value => switch (this) {
        SharingResource.userProfile => 'userProfile',
        SharingResource.stressScores => 'stressScores',
        SharingResource.moodEntries => 'moodEntries',
        SharingResource.calendar => 'calendar',
      };

  String get displayName => switch (this) {
        SharingResource.userProfile => 'Profile',
        SharingResource.stressScores => 'Stress Scores',
        SharingResource.moodEntries => 'Mood Entries',
        SharingResource.calendar => 'Calendar',
      };
}

extension SharingEffectExt on SharingEffect {
  String get value => switch (this) {
        SharingEffect.allow => 'allow',
        SharingEffect.deny => 'deny',
      };
}

class SharingRuleModel {
  final String id;
  final String viewerId;
  final SharingResource resource;
  final SharingEffect effect;

  const SharingRuleModel({
    required this.id,
    required this.viewerId,
    required this.resource,
    required this.effect,
  });

  factory SharingRuleModel.fromJson(Map<String, dynamic> json) {
    return SharingRuleModel(
      id: json['id']?.toString() ?? '',
      viewerId: json['viewerId']?.toString() ?? '',
      resource: _parseResource(json['resource']?.toString() ?? ''),
      effect: _parseEffect(json['effect']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() => {
        'viewerId': viewerId,
        'resource': resource.value,
        'effect': effect.value,
      };

  static SharingResource _parseResource(String raw) => switch (raw) {
        'userProfile' => SharingResource.userProfile,
        'stressScores' => SharingResource.stressScores,
        'moodEntries' => SharingResource.moodEntries,
        'calendar' => SharingResource.calendar,
        _ => SharingResource.userProfile,
      };

  static SharingEffect _parseEffect(String raw) => switch (raw) {
        'allow' => SharingEffect.allow,
        'deny' => SharingEffect.deny,
        _ => SharingEffect.deny,
      };
}
