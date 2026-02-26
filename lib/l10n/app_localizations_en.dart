// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Endurance';

  @override
  String get tagline => 'Services Beyond Service';

  @override
  String get homeWelcome => 'Welcome back. You are not alone.';

  @override
  String get accessRestricted => 'Access Restricted';

  @override
  String get accessRestrictedBody =>
      'Sorry, access to Endurance is reserved for verified veterans. Your account does not currently have the required access.';

  @override
  String get useWebVersion => 'Use our web version instead';

  @override
  String get logout => 'Logout';

  @override
  String get welcomeDescription =>
      'A safe space built for those who served. Endurance connects you with the people who matter most, on your own terms, at your own pace.';

  @override
  String get featurePrivacyTitle => 'Your privacy, always';

  @override
  String get featurePrivacyDesc =>
      'No tracking, no surveillance. You are in full control of who sees what.';

  @override
  String get featureMentalHealthTitle => 'Mental health insights';

  @override
  String get featureMentalHealthDesc =>
      'Share your daily check-ins and smartwatch data with your therapist, only if you choose to.';

  @override
  String get featureConnectedTitle => 'Stay connected';

  @override
  String get featureConnectedDesc =>
      'Reach out to friends, family, therapists and fellow veterans in one secure place.';

  @override
  String get featureSharingTitle => 'Permission-based sharing';

  @override
  String get featureSharingDesc =>
      'You decide exactly what your support network can see. Revoke access any time.';

  @override
  String get getStarted => 'Get Started';
}
