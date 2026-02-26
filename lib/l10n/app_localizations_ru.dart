// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Endurance';

  @override
  String get tagline => 'Услуги Сверх Службы';

  @override
  String get homeWelcome => 'С возвращением. Вы не одиноки.';

  @override
  String get accessRestricted => 'Доступ Ограничен';

  @override
  String get accessRestrictedBody =>
      'Извините, доступ к Endurance зарезервирован для проверенных ветеранов. Ваша учётная запись в настоящее время не имеет необходимого доступа.';

  @override
  String get useWebVersion => 'Используйте нашу веб-версию';

  @override
  String get logout => 'Выйти';

  @override
  String get welcomeDescription =>
      'Безопасное пространство для тех, кто служил. Endurance соединяет вас с людьми, которые важны для вас больше всего, на ваших условиях, в вашем темпе.';

  @override
  String get featurePrivacyTitle => 'Ваша конфиденциальность, всегда';

  @override
  String get featurePrivacyDesc =>
      'Без отслеживания и слежки. Вы полностью контролируете, кто что видит.';

  @override
  String get featureMentalHealthTitle => 'Состояние психического здоровья';

  @override
  String get featureMentalHealthDesc =>
      'Делитесь ежедневными отметками и данными умных часов со своим терапевтом, только если вы решите это сделать.';

  @override
  String get featureConnectedTitle => 'Оставайтесь на связи';

  @override
  String get featureConnectedDesc =>
      'Свяжитесь с друзьями, семьёй, терапевтами и сослуживцами в одном безопасном месте.';

  @override
  String get featureSharingTitle => 'Совместный доступ на основе разрешений';

  @override
  String get featureSharingDesc =>
      'Вы решаете, что именно может видеть ваша сеть поддержки. Отозвать доступ можно в любое время.';

  @override
  String get getStarted => 'Начать';
}
