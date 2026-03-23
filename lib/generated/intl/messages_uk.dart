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

  static String m2(score) => "сер. ${score} сьогодні";

  static String m3(score) => "${score}/10";

  static String m4(count) => "${count} год тому";

  static String m5(count) => "${count} хв тому";

  static String m6(score) => "Настрій: ${score}/10";

  static String m7(date) => "Обчислено ${date}";

  static String m8(score) => "Рівень стресу: ${score}";

  static String m9(name) => "${name} буде видалено з вашої мережі підтримки.";

  static String m10(username) => "Запит надіслано @${username}";

  static String m11(error) => "Помилка видалення акаунту: ${error}";

  static String m12(error) => "Помилка оновлення профілю: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage("Доступ Обмежено"),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Вибачте, доступ до Endurance зарезервований для перевірених ветеранів. Ваш обліковий запис наразі не має необхідного доступу.",
    ),
    "agendaAddAvailability": MessageLookupByLibrary.simpleMessage(
      "Додати доступність",
    ),
    "agendaAddSlotButton": MessageLookupByLibrary.simpleMessage("Додати"),
    "agendaAddSlotDuration": MessageLookupByLibrary.simpleMessage("Тривалість"),
    "agendaAddSlotError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося додати доступність. Спробуйте ще раз.",
    ),
    "agendaAddSlotRecurring": MessageLookupByLibrary.simpleMessage(
      "Повторювати щотижня",
    ),
    "agendaAddSlotRecurringHint": MessageLookupByLibrary.simpleMessage(
      "Створює доступність на наступні 8 тижнів",
    ),
    "agendaAddSlotStartTime": MessageLookupByLibrary.simpleMessage(
      "Час початку",
    ),
    "agendaAddSlotSuccess": MessageLookupByLibrary.simpleMessage(
      "Доступність додана!",
    ),
    "agendaBookButton": MessageLookupByLibrary.simpleMessage("Записатися"),
    "agendaBookError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося забронювати слот. Спробуйте ще раз.",
    ),
    "agendaBookUrgentSlot": MessageLookupByLibrary.simpleMessage(
      "Book urgent slot",
    ),
    "agendaBookedSuccess": MessageLookupByLibrary.simpleMessage(
      "Зустріч заброньована!",
    ),
    "agendaCancelBody": MessageLookupByLibrary.simpleMessage(
      "Це звільнить часовий слот для інших.",
    ),
    "agendaCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "Скасувати зустріч",
    ),
    "agendaCancelTitle": MessageLookupByLibrary.simpleMessage(
      "Скасувати зустріч?",
    ),
    "agendaCancelledSuccess": MessageLookupByLibrary.simpleMessage(
      "Зустріч скасовано",
    ),
    "agendaEmptyAvailability": MessageLookupByLibrary.simpleMessage(
      "Доступність не задана",
    ),
    "agendaEmptyAvailabilityBody": MessageLookupByLibrary.simpleMessage(
      "Додайте часові вікна для вашої мережі.",
    ),
    "agendaEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Забронюйте час у когось із вашої мережі підтримки.",
    ),
    "agendaEmptyTitle": MessageLookupByLibrary.simpleMessage("Немає зустрічей"),
    "agendaExportCalendar": MessageLookupByLibrary.simpleMessage(
      "Експорт календаря",
    ),
    "agendaExportError": MessageLookupByLibrary.simpleMessage(
      "Не вдалося експортувати календар. Спробуйте ще раз.",
    ),
    "agendaExportSuccess": MessageLookupByLibrary.simpleMessage(
      "Календар експортовано!",
    ),
    "agendaHighRiskBody": MessageLookupByLibrary.simpleMessage(
      "Your care team has flagged you as high risk. Please reach out.",
    ),
    "agendaHighRiskTitle": MessageLookupByLibrary.simpleMessage(
      "You may need support",
    ),
    "agendaNoAppointmentsBody": MessageLookupByLibrary.simpleMessage(
      "Забронюйте слот через вашу мережу.",
    ),
    "agendaNoSlots": MessageLookupByLibrary.simpleMessage(
      "Немає доступних слотів на наступні 30 днів",
    ),
    "agendaNoUrgentSlots": MessageLookupByLibrary.simpleMessage(
      "No urgent slots available right now",
    ),
    "agendaPast": MessageLookupByLibrary.simpleMessage("МИНУЛІ"),
    "agendaSlotAvailable": MessageLookupByLibrary.simpleMessage("Доступно"),
    "agendaSlotBooked": MessageLookupByLibrary.simpleMessage("Заброньовано"),
    "agendaSlotDeleteAllSeries": MessageLookupByLibrary.simpleMessage(
      "Всі майбутні",
    ),
    "agendaSlotDeleteBody": MessageLookupByLibrary.simpleMessage(
      "Це часове вікно буде видалено.",
    ),
    "agendaSlotDeleteConfirm": MessageLookupByLibrary.simpleMessage("Видалити"),
    "agendaSlotDeleteSeriesTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити повторювану доступність?",
    ),
    "agendaSlotDeleteThisOnly": MessageLookupByLibrary.simpleMessage(
      "Тільки цю",
    ),
    "agendaSlotDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити доступність?",
    ),
    "agendaSlotDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Доступність видалено",
    ),
    "agendaTabAppointments": MessageLookupByLibrary.simpleMessage("Зустрічі"),
    "agendaTabAvailability": MessageLookupByLibrary.simpleMessage(
      "Моя доступність",
    ),
    "agendaTalkToTherapist": MessageLookupByLibrary.simpleMessage(
      "Talk to therapist",
    ),
    "agendaTitle": MessageLookupByLibrary.simpleMessage("Розклад"),
    "agendaUpcoming": MessageLookupByLibrary.simpleMessage("МАЙБУТНІ"),
    "agendaUpcomingNoAppointments": MessageLookupByLibrary.simpleMessage(
      "Немає майбутніх зустрічей",
    ),
    "agendaUrgentAppointment": MessageLookupByLibrary.simpleMessage(
      "Urgent appointment",
    ),
    "agendaUrgentLabel": MessageLookupByLibrary.simpleMessage("Urgent"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Скасувати"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage(
      "Додати перевірку",
    ),
    "checkInAvgToday": m2,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Щось пішло не так. Спробуйте ще раз.",
    ),
    "checkInScoreLabel": m3,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Перевірку надіслано!",
    ),
    "checkInTimeAgoHours": m4,
    "checkInTimeAgoMinutes": m5,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Виконати перевірку",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Перевірку завершено",
    ),
    "dailyCheckInDoneSubtitle": m6,
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
    "healthCategoryHigh": MessageLookupByLibrary.simpleMessage("Високий"),
    "healthCategoryLow": MessageLookupByLibrary.simpleMessage("Низький"),
    "healthCategoryModerate": MessageLookupByLibrary.simpleMessage("Помірний"),
    "healthCategoryVeryHigh": MessageLookupByLibrary.simpleMessage(
      "Дуже високий",
    ),
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Включити дані про здоров\'я",
    ),
    "healthDeleteAllMoodBody": MessageLookupByLibrary.simpleMessage(
      "Це назавжди видалить усі ваші записи про настрій.",
    ),
    "healthDeleteAllMoodButton": MessageLookupByLibrary.simpleMessage(
      "Видалити всі дані про настрій",
    ),
    "healthDeleteAllMoodConfirm": MessageLookupByLibrary.simpleMessage(
      "Видалити все",
    ),
    "healthDeleteAllMoodTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити всі дані про настрій?",
    ),
    "healthDeleteError": MessageLookupByLibrary.simpleMessage(
      "Щось пішло не так. Спробуйте ще раз.",
    ),
    "healthDeleteStressBody": MessageLookupByLibrary.simpleMessage(
      "Це назавжди видалить усі ваші показники стресу та дані датчиків.",
    ),
    "healthDeleteStressButton": MessageLookupByLibrary.simpleMessage(
      "Видалити всі дані про здоров\'я",
    ),
    "healthDeleteStressConfirm": MessageLookupByLibrary.simpleMessage(
      "Видалити все",
    ),
    "healthDeleteStressTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити всі дані про здоров\'я?",
    ),
    "healthEntryDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Видалити",
    ),
    "healthEntryDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити запис?",
    ),
    "healthInsightsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "АНАЛІТИКА",
    ),
    "healthMoodAllDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Усі дані про настрій видалено",
    ),
    "healthMoodDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Запис про настрій видалено",
    ),
    "healthMoodSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ІСТОРІЯ НАСТРОЮ",
    ),
    "healthNoInsights": MessageLookupByLibrary.simpleMessage(
      "Ще немає аналітики",
    ),
    "healthNoInsightsBody": MessageLookupByLibrary.simpleMessage(
      "Виконайте перевірку з даними смарт-годинника, щоб побачити показники стресу.",
    ),
    "healthNoMoodEntries": MessageLookupByLibrary.simpleMessage(
      "Немає записів про настрій цього тижня",
    ),
    "healthOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Мої дані про здоров\'я",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Надати доступ",
    ),
    "healthStressComputedAt": m7,
    "healthStressDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Усі дані про здоров\'я видалено",
    ),
    "healthStressScoreLabel": m8,
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage("З поверненням,"),
    "logout": MessageLookupByLibrary.simpleMessage("Вийти"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage("Огляд настрою"),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ЦЕЙ ТИЖДЕНЬ",
    ),
    "navAgenda": MessageLookupByLibrary.simpleMessage("Розклад"),
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
    "networkBookAppointment": MessageLookupByLibrary.simpleMessage(
      "Записатися на прийом",
    ),
    "networkBookAppointmentSubtitle": MessageLookupByLibrary.simpleMessage(
      "Переглянути доступні слоти",
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
    "networkPrivacySettings": MessageLookupByLibrary.simpleMessage(
      "Налаштування конфіденційності",
    ),
    "networkPrivacySettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Керуйте доступом цієї людини",
    ),
    "networkRemove": MessageLookupByLibrary.simpleMessage("Видалити"),
    "networkRemoveBody": m9,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Видалити"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити з мережі?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Видалено з мережі",
    ),
    "networkRequestSentSuccess": m10,
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
    "profileDeleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Видалити акаунт",
    ),
    "profileDeleteError": m11,
    "profileDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "Ви впевнені, що хочете назавжди видалити свій акаунт? Цю дію не можна скасувати, усі ваші дані буде втрачено.",
    ),
    "profileDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Видалити акаунт",
    ),
    "profileEditAbout": MessageLookupByLibrary.simpleMessage("Про мене"),
    "profileEditAboutHint": MessageLookupByLibrary.simpleMessage(
      "Детальніше про себе (макс. 500 символів)",
    ),
    "profileEditButton": MessageLookupByLibrary.simpleMessage(
      "Редагувати профіль",
    ),
    "profileEditCity": MessageLookupByLibrary.simpleMessage("Місто"),
    "profileEditCountry": MessageLookupByLibrary.simpleMessage("Країна"),
    "profileEditFirstName": MessageLookupByLibrary.simpleMessage("Ім\'я"),
    "profileEditFirstNameRequired": MessageLookupByLibrary.simpleMessage(
      "Ім\'я обов\'язкове",
    ),
    "profileEditIntroduction": MessageLookupByLibrary.simpleMessage("Вступ"),
    "profileEditIntroductionHint": MessageLookupByLibrary.simpleMessage(
      "Короткий опис того, хто ви є",
    ),
    "profileEditLastName": MessageLookupByLibrary.simpleMessage("Прізвище"),
    "profileEditPhone": MessageLookupByLibrary.simpleMessage("Номер телефону"),
    "profileEditPhotoUrl": MessageLookupByLibrary.simpleMessage(
      "URL фото профілю",
    ),
    "profileEditPhotoUrlHint": MessageLookupByLibrary.simpleMessage(
      "Введіть публічне посилання на зображення",
    ),
    "profileEditPostalCode": MessageLookupByLibrary.simpleMessage(
      "Поштовий індекс",
    ),
    "profileEditRegion": MessageLookupByLibrary.simpleMessage("Регіон / Штат"),
    "profileEditSaveButton": MessageLookupByLibrary.simpleMessage(
      "Зберегти зміни",
    ),
    "profileEditSectionAddress": MessageLookupByLibrary.simpleMessage("АДРЕСА"),
    "profileEditSectionBio": MessageLookupByLibrary.simpleMessage("ПРО МЕНЕ"),
    "profileEditSectionContact": MessageLookupByLibrary.simpleMessage(
      "КОНТАКТИ",
    ),
    "profileEditSectionName": MessageLookupByLibrary.simpleMessage("ІМ\'Я"),
    "profileEditSectionPhoto": MessageLookupByLibrary.simpleMessage("ФОТО"),
    "profileEditStreet": MessageLookupByLibrary.simpleMessage("Вулиця"),
    "profileEditTitle": MessageLookupByLibrary.simpleMessage(
      "Редагувати профіль",
    ),
    "profileLabelAddress": MessageLookupByLibrary.simpleMessage("Адреса"),
    "profileLabelEmail": MessageLookupByLibrary.simpleMessage("Ел. пошта"),
    "profileLabelPhone": MessageLookupByLibrary.simpleMessage("Телефон"),
    "profileLabelPrivacy": MessageLookupByLibrary.simpleMessage(
      "Конфіденційність",
    ),
    "profilePrivateAccount": MessageLookupByLibrary.simpleMessage(
      "Закритий акаунт",
    ),
    "profilePublicAccount": MessageLookupByLibrary.simpleMessage(
      "Відкритий акаунт",
    ),
    "profileSectionAbout": MessageLookupByLibrary.simpleMessage("ПРО МЕНЕ"),
    "profileSectionIntroduction": MessageLookupByLibrary.simpleMessage("ВСТУП"),
    "profileSignOut": MessageLookupByLibrary.simpleMessage("Вийти"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Профіль"),
    "profileUpdateError": m12,
    "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Профіль успішно оновлено",
    ),
    "profileUsernameCopied": MessageLookupByLibrary.simpleMessage(
      "Ім\'я користувача скопійовано",
    ),
    "quickActionsBookSession": MessageLookupByLibrary.simpleMessage(
      "Записатись\nна сеанс",
    ),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Лінія\nкризи",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Написати\nдругу",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ШВИДКІ ДІЇ",
    ),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Надіслати"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("ще"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "МОЯ МЕРЕЖА ПІДТРИМКИ",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Послуги Понад Службою"),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("НАЙБЛИЖЧЕ"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Скористайтеся нашою веб-версією",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "Безпечний простір для тих, хто служив. Endurance поєднує вас з людьми, які мають для вас найбільше значення, на ваших умовах, у вашому темпі.",
    ),
  };
}
