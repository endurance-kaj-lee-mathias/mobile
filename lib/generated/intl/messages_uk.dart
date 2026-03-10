// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'uk';

  static String m0(score) => "сер. ${score} сьогодні";

  static String m1(score) => "${score}/10";

  static String m2(count) => "${count} год тому";

  static String m3(count) => "${count} хв тому";

  static String m4(score) => "Настрій: ${score}/10";

  static String m5(name) => "${name} буде видалено з вашої мережі підтримки.";

  static String m6(username) => "Запит надіслано @${username}";

  static String m7(minutes) => "${minutes} хв читання";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage("Доступ Обмежено"),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Вибачте, доступ до Endurance зарезервований для перевірених ветеранів. Ваш обліковий запис наразі не має необхідного доступу.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "chatsSoon": MessageLookupByLibrary.simpleMessage("Чати — незабаром"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage(
      "Додати перевірку",
    ),
    "checkInAvgToday": m0,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Щось пішло не так. Спробуйте ще раз.",
    ),
    "checkInScoreLabel": m1,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Перевірку надіслано!",
    ),
    "checkInTimeAgoHours": m2,
    "checkInTimeAgoMinutes": m3,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Виконати перевірку",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Перевірку завершено",
    ),
    "dailyCheckInDoneSubtitle": m4,
    "dailyCheckInPending": MessageLookupByLibrary.simpleMessage(
      "Як ви себе почуваєте сьогодні?",
    ),
    "dailyCheckInTitle": MessageLookupByLibrary.simpleMessage(
      "Щоденна перевірка",
    ),
    "featureConnectedDesc": MessageLookupByLibrary.simpleMessage(
      "Зв\'яжіться з друзьями, родиною, терапевтами та товаришами-ветеранами в одному безпечному місці.",
    ),
    "featureConnectedTitle": MessageLookupByLibrary.simpleMessage(
      "Залишайтеся на зв\'язку",
    ),
    "featureMentalHealthDesc": MessageLookupByLibrary.simpleMessage(
      "Діліться щоденними перевірками та даними смарт-годинника зі своїм терапевтом, лише якщо ви вирішите це зробити.",
    ),
    "featureMentalHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Стан психічного здоров\'я",
    ),
    "featurePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Без відстеження та стеження. Ви повністю контролюєте, хто що бачить.",
    ),
    "featurePrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша конфіденційність, завжди",
    ),
    "featureSharingDesc": MessageLookupByLibrary.simpleMessage(
      "Ви вирішуєте, що саме може бачити ваша мережа підтримки. Відкличте доступ у будь-який час.",
    ),
    "featureSharingTitle": MessageLookupByLibrary.simpleMessage(
      "Спільний доступ на основі дозволів",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Почати"),
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Дані про здоров\'я будуть включені",
    ),
    "healthPermissionBody": MessageLookupByLibrary.simpleMessage(
      "Дозвольте Endurance читати дані про здоров\'я (пульс, кроки, сон) для збагачення перевірки.",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Надати доступ",
    ),
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage("З поверненням,"),
    "logout": MessageLookupByLibrary.simpleMessage("Вийти"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage("Огляд настрою"),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ЦЕЙ ТИЖДЕНЬ",
    ),
    "navChats": MessageLookupByLibrary.simpleMessage("Чати"),
    "navHome": MessageLookupByLibrary.simpleMessage("Головна"),
    "navNetwork": MessageLookupByLibrary.simpleMessage("Моя Мережа"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Профіль"),
    "networkAccept": MessageLookupByLibrary.simpleMessage("Прийняти"),
    "networkAcceptedSuccess": MessageLookupByLibrary.simpleMessage(
      "Зв\'язок прийнято",
    ),
    "networkAddSomeone": MessageLookupByLibrary.simpleMessage("Додати когось"),
    "networkAddToNetwork": MessageLookupByLibrary.simpleMessage(
      "Додати до мережі",
    ),
    "networkConnections": MessageLookupByLibrary.simpleMessage("Зв\'язки"),
    "networkDeclinedSuccess": MessageLookupByLibrary.simpleMessage(
      "Запит відхилено",
    ),
    "networkDeny": MessageLookupByLibrary.simpleMessage("Відхилити"),
    "networkEmptyConnections": MessageLookupByLibrary.simpleMessage(
      "Немає зв\'язків",
    ),
    "networkEmptyConnectionsBody": MessageLookupByLibrary.simpleMessage(
      "Надсилайте запити на зв\'язок, щоб розширити мережу підтримки.",
    ),
    "networkEmptyIncoming": MessageLookupByLibrary.simpleMessage(
      "Немає вхідних запитів",
    ),
    "networkEmptyRequests": MessageLookupByLibrary.simpleMessage(
      "Немає запитів",
    ),
    "networkEmptyRequestsBody": MessageLookupByLibrary.simpleMessage(
      "У вас немає вхідних або вихідних запитів на зв\'язок.",
    ),
    "networkEmptySent": MessageLookupByLibrary.simpleMessage(
      "Немає очікуючих запитів",
    ),
    "networkErrorAlreadyConnected": MessageLookupByLibrary.simpleMessage(
      "Вже підключені або запит вже очікує розгляду",
    ),
    "networkErrorCannotRemove": MessageLookupByLibrary.simpleMessage(
      "Не вдається видалити цей зв\'язок. Це може бути відоме обмеження сервера — попросіть їх видалити вас.",
    ),
    "networkErrorCannotSend": MessageLookupByLibrary.simpleMessage(
      "Не вдається надіслати запит цьому користувачу",
    ),
    "networkErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Щось пішло не так. Будь ласка, спробуйте ще раз.",
    ),
    "networkErrorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "Користувача не знайдено",
    ),
    "networkGroupOther": MessageLookupByLibrary.simpleMessage("ІНШІ"),
    "networkGroupSupport": MessageLookupByLibrary.simpleMessage(
      "МЕРЕЖА ПІДТРИМКИ",
    ),
    "networkGroupTherapists": MessageLookupByLibrary.simpleMessage("ТЕРАПЕВТИ"),
    "networkGroupVeterans": MessageLookupByLibrary.simpleMessage("ВЕТЕРАНИ"),
    "networkIncoming": MessageLookupByLibrary.simpleMessage("ВХІДНІ"),
    "networkNoteHint": MessageLookupByLibrary.simpleMessage(
      "Додайте особисте повідомлення...",
    ),
    "networkNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Нотатка (необов\'язково)",
    ),
    "networkPendingLabel": MessageLookupByLibrary.simpleMessage("Очікує"),
    "networkRemove": MessageLookupByLibrary.simpleMessage("Видалити"),
    "networkRemoveBody": m5,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Видалити"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити з мережі?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Видалено з мережі",
    ),
    "networkRequestSentSuccess": m6,
    "networkRequests": MessageLookupByLibrary.simpleMessage("Запити"),
    "networkRoleSupport": MessageLookupByLibrary.simpleMessage(
      "Мережа підтримки",
    ),
    "networkRoleTherapist": MessageLookupByLibrary.simpleMessage("Терапевт"),
    "networkRoleVeteran": MessageLookupByLibrary.simpleMessage("Ветеран"),
    "networkSendRequest": MessageLookupByLibrary.simpleMessage(
      "Надіслати запит",
    ),
    "networkSent": MessageLookupByLibrary.simpleMessage("НАДІСЛАНІ"),
    "networkSoon": MessageLookupByLibrary.simpleMessage("Мережа — незабаром"),
    "networkTitle": MessageLookupByLibrary.simpleMessage("Моя Мережа"),
    "networkUsernameHint": MessageLookupByLibrary.simpleMessage(
      "напр. ivan_petrenko",
    ),
    "networkUsernameLabel": MessageLookupByLibrary.simpleMessage(
      "Ім\'я користувача",
    ),
    "networkUsernameRequired": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть ім\'я користувача",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "Як ви себе почуваєте? (макс. 500 символів)",
    ),
    "notesLabel": MessageLookupByLibrary.simpleMessage(
      "Нотатки (необов\'язково)",
    ),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Профіль"),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Лінія\nкризи",
    ),
    "quickActionsFindTherapist": MessageLookupByLibrary.simpleMessage(
      "Знайти\nтерапевта",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Написати\nдругу",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ШВИДКІ ДІЇ",
    ),
    "resourceCategoryCommunity": MessageLookupByLibrary.simpleMessage(
      "Спільнота",
    ),
    "resourceCategoryMentalHealth": MessageLookupByLibrary.simpleMessage(
      "Психічне здоров\'я",
    ),
    "resourceCategoryPhysical": MessageLookupByLibrary.simpleMessage("Фізичне"),
    "resourceCategoryWellbeing": MessageLookupByLibrary.simpleMessage(
      "Добробут",
    ),
    "resourceReadTime": m7,
    "resourceTitle1": MessageLookupByLibrary.simpleMessage(
      "Управління тривогою\nу повсякденному житті",
    ),
    "resourceTitle2": MessageLookupByLibrary.simpleMessage(
      "Знайдіть\nсвою групу ветеранів",
    ),
    "resourceTitle3": MessageLookupByLibrary.simpleMessage(
      "Техніки сну\nдля ветеранів",
    ),
    "resourceTitle4": MessageLookupByLibrary.simpleMessage(
      "Вправи як\nінструмент відновлення",
    ),
    "resourcesSectionTitle": MessageLookupByLibrary.simpleMessage("РЕСУРСИ"),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Надіслати"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("ще"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "МОЯ МЕРЕЖА ПІДТРИМКИ",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Послуги Понад Службою"),
    "upcomingAppointmentTime": MessageLookupByLibrary.simpleMessage(
      "Завтра · 14:00",
    ),
    "upcomingAppointmentTitle": MessageLookupByLibrary.simpleMessage(
      "Сеанс терапії",
    ),
    "upcomingAppointmentWith": MessageLookupByLibrary.simpleMessage(
      "з Др. Сарою Мітчелл",
    ),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("НАЙБЛИЖЧЕ"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Скористайтеся нашою веб-версією",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "Безпечний простір для тих, хто служив. Endurance поєднує вас з людьми, які мають для вас найбільше значення, на ваших умовах, у вашому темпі.",
    ),
  };
}
