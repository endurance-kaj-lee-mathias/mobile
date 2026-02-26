// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Endurance';

  @override
  String get tagline => 'Послуги Понад Службою';

  @override
  String get homeWelcome => 'З поверненням. Ви не самотні.';

  @override
  String get accessRestricted => 'Доступ Обмежено';

  @override
  String get accessRestrictedBody =>
      'Вибачте, доступ до Endurance зарезервований для перевірених ветеранів. Ваш обліковий запис наразі не має необхідного доступу.';

  @override
  String get useWebVersion => 'Скористайтеся нашою веб-версією';

  @override
  String get logout => 'Вийти';

  @override
  String get welcomeDescription =>
      'Безпечний простір для тих, хто служив. Endurance поєднує вас з людьми, які мають для вас найбільше значення, на ваших умовах, у вашому темпі.';

  @override
  String get featurePrivacyTitle => 'Ваша конфіденційність, завжди';

  @override
  String get featurePrivacyDesc =>
      'Без відстеження та стеження. Ви повністю контролюєте, хто що бачить.';

  @override
  String get featureMentalHealthTitle => 'Стан психічного здоров\'я';

  @override
  String get featureMentalHealthDesc =>
      'Діліться щоденними перевірками та даними смарт-годинника зі своїм терапевтом, лише якщо ви вирішите це зробити.';

  @override
  String get featureConnectedTitle => 'Залишайтеся на зв\'язку';

  @override
  String get featureConnectedDesc =>
      'Зв\'яжіться з друзями, родиною, терапевтами та товаришами-ветеранами в одному безпечному місці.';

  @override
  String get featureSharingTitle => 'Спільний доступ на основі дозволів';

  @override
  String get featureSharingDesc =>
      'Ви вирішуєте, що саме може бачити ваша мережа підтримки. Відкличте доступ у будь-який час.';

  @override
  String get getStarted => 'Почати';
}
