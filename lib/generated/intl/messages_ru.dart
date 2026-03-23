// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m2(score) => "ср. ${score} сегодня";

  static String m3(score) => "${score}/10";

  static String m4(count) => "${count} ч. назад";

  static String m5(count) => "${count} мин. назад";

  static String m6(score) => "Настроение: ${score}/10";

  static String m7(date) => "Вычислено ${date}";

  static String m8(score) => "Уровень стресса: ${score}";

  static String m9(name) => "${name} будет удалён из вашей сети поддержки.";

  static String m10(username) => "Запрос отправлен @${username}";

  static String m11(error) => "Ошибка удаления аккаунта: ${error}";

  static String m12(error) => "Ошибка обновления профиля: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage(
      "Доступ Ограничен",
    ),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Извините, доступ к Endurance зарезервирован для проверенных ветеранов. Ваша учётная запись в настоящее время не имеет необходимого доступа.",
    ),
    "agendaAddAvailability": MessageLookupByLibrary.simpleMessage(
      "Добавить доступность",
    ),
    "agendaAddSlotButton": MessageLookupByLibrary.simpleMessage("Добавить"),
    "agendaAddSlotDuration": MessageLookupByLibrary.simpleMessage(
      "Продолжительность",
    ),
    "agendaAddSlotError": MessageLookupByLibrary.simpleMessage(
      "Не удалось добавить доступность. Попробуйте ещё раз.",
    ),
    "agendaAddSlotRecurring": MessageLookupByLibrary.simpleMessage(
      "Повторять еженедельно",
    ),
    "agendaAddSlotRecurringHint": MessageLookupByLibrary.simpleMessage(
      "Создаёт доступность на ближайшие 8 недель",
    ),
    "agendaAddSlotStartTime": MessageLookupByLibrary.simpleMessage(
      "Время начала",
    ),
    "agendaAddSlotSuccess": MessageLookupByLibrary.simpleMessage(
      "Доступность добавлена!",
    ),
    "agendaBookButton": MessageLookupByLibrary.simpleMessage("Записаться"),
    "agendaBookError": MessageLookupByLibrary.simpleMessage(
      "Не удалось забронировать слот. Попробуйте ещё раз.",
    ),
    "agendaBookUrgentSlot": MessageLookupByLibrary.simpleMessage(
      "Book urgent slot",
    ),
    "agendaBookedSuccess": MessageLookupByLibrary.simpleMessage(
      "Встреча забронирована!",
    ),
    "agendaCancelBody": MessageLookupByLibrary.simpleMessage(
      "Это освободит временной слот для других.",
    ),
    "agendaCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "Отменить встречу",
    ),
    "agendaCancelTitle": MessageLookupByLibrary.simpleMessage(
      "Отменить встречу?",
    ),
    "agendaCancelledSuccess": MessageLookupByLibrary.simpleMessage(
      "Встреча отменена",
    ),
    "agendaEmptyAvailability": MessageLookupByLibrary.simpleMessage(
      "Доступность не задана",
    ),
    "agendaEmptyAvailabilityBody": MessageLookupByLibrary.simpleMessage(
      "Добавьте временные окна для вашей сети.",
    ),
    "agendaEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Забронируйте время у кого-то из вашей сети поддержки.",
    ),
    "agendaEmptyTitle": MessageLookupByLibrary.simpleMessage("Нет встреч"),
    "agendaExportCalendar": MessageLookupByLibrary.simpleMessage(
      "Экспорт календаря",
    ),
    "agendaExportError": MessageLookupByLibrary.simpleMessage(
      "Не удалось экспортировать календарь. Попробуйте ещё раз.",
    ),
    "agendaExportSuccess": MessageLookupByLibrary.simpleMessage(
      "Календарь экспортирован!",
    ),
    "agendaHighRiskBody": MessageLookupByLibrary.simpleMessage(
      "Your care team has flagged you as high risk. Please reach out.",
    ),
    "agendaHighRiskTitle": MessageLookupByLibrary.simpleMessage(
      "You may need support",
    ),
    "agendaNoAppointmentsBody": MessageLookupByLibrary.simpleMessage(
      "Забронируйте слот через ваш нетворк.",
    ),
    "agendaNoSlots": MessageLookupByLibrary.simpleMessage(
      "Нет доступных слотов на ближайшие 30 дней",
    ),
    "agendaNoUrgentSlots": MessageLookupByLibrary.simpleMessage(
      "No urgent slots available right now",
    ),
    "agendaPast": MessageLookupByLibrary.simpleMessage("ПРОШЕДШИЕ"),
    "agendaSlotAvailable": MessageLookupByLibrary.simpleMessage("Доступно"),
    "agendaSlotBooked": MessageLookupByLibrary.simpleMessage("Забронировано"),
    "agendaSlotDeleteAllSeries": MessageLookupByLibrary.simpleMessage(
      "Все будущие",
    ),
    "agendaSlotDeleteBody": MessageLookupByLibrary.simpleMessage(
      "Это временное окно будет удалено.",
    ),
    "agendaSlotDeleteConfirm": MessageLookupByLibrary.simpleMessage("Удалить"),
    "agendaSlotDeleteSeriesTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить повторяющуюся доступность?",
    ),
    "agendaSlotDeleteThisOnly": MessageLookupByLibrary.simpleMessage(
      "Только эту",
    ),
    "agendaSlotDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Убрать доступность?",
    ),
    "agendaSlotDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Доступность удалена",
    ),
    "agendaTabAppointments": MessageLookupByLibrary.simpleMessage("Встречи"),
    "agendaTabAvailability": MessageLookupByLibrary.simpleMessage(
      "Моя доступность",
    ),
    "agendaTalkToTherapist": MessageLookupByLibrary.simpleMessage(
      "Talk to therapist",
    ),
    "agendaTitle": MessageLookupByLibrary.simpleMessage("Расписание"),
    "agendaUpcoming": MessageLookupByLibrary.simpleMessage("ПРЕДСТОЯЩИЕ"),
    "agendaUpcomingNoAppointments": MessageLookupByLibrary.simpleMessage(
      "Нет предстоящих встреч",
    ),
    "agendaUrgentAppointment": MessageLookupByLibrary.simpleMessage(
      "Urgent appointment",
    ),
    "agendaUrgentLabel": MessageLookupByLibrary.simpleMessage("Urgent"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage(
      "Добавить отметку",
    ),
    "checkInAvgToday": m2,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так. Повторите попытку.",
    ),
    "checkInScoreLabel": m3,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Отметка отправлена!",
    ),
    "checkInTimeAgoHours": m4,
    "checkInTimeAgoMinutes": m5,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Заполнить отметку",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Отметка выполнена",
    ),
    "dailyCheckInDoneSubtitle": m6,
    "dailyCheckInPending": MessageLookupByLibrary.simpleMessage(
      "Как вы себя чувствуете сегодня?",
    ),
    "dailyCheckInTitle": MessageLookupByLibrary.simpleMessage(
      "Ежедневная отметка",
    ),
    "featureConnectedDesc": MessageLookupByLibrary.simpleMessage(
      "Свяжитесь с друзьями, семьёй, терапевтами и сослуживцами в одном безопасном месте.",
    ),
    "featureConnectedTitle": MessageLookupByLibrary.simpleMessage(
      "Оставайтесь на связи",
    ),
    "featureMentalHealthDesc": MessageLookupByLibrary.simpleMessage(
      "Делитесь ежедневными отметками и данными умных часов со своим терапевтом, только если вы решите это сделать.",
    ),
    "featureMentalHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Состояние психического здоровья",
    ),
    "featurePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Без отслеживания и слежки. Вы полностью контролируете, кто что видит.",
    ),
    "featurePrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Ваша конфиденциальность, всегда",
    ),
    "featureSharingDesc": MessageLookupByLibrary.simpleMessage(
      "Вы решаете, что именно может видеть ваша сеть поддержки. Отозвать доступ можно в любое время.",
    ),
    "featureSharingTitle": MessageLookupByLibrary.simpleMessage(
      "Совместный доступ на основе разрешений",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Начать"),
    "healthCategoryHigh": MessageLookupByLibrary.simpleMessage("Высокий"),
    "healthCategoryLow": MessageLookupByLibrary.simpleMessage("Низкий"),
    "healthCategoryModerate": MessageLookupByLibrary.simpleMessage("Умеренный"),
    "healthCategoryVeryHigh": MessageLookupByLibrary.simpleMessage(
      "Очень высокий",
    ),
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Включить данные о здоровье",
    ),
    "healthDeleteAllMoodBody": MessageLookupByLibrary.simpleMessage(
      "Это безвозвратно удалит все ваши записи о настроении.",
    ),
    "healthDeleteAllMoodButton": MessageLookupByLibrary.simpleMessage(
      "Удалить все данные о настроении",
    ),
    "healthDeleteAllMoodConfirm": MessageLookupByLibrary.simpleMessage(
      "Удалить всё",
    ),
    "healthDeleteAllMoodTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить все данные о настроении?",
    ),
    "healthDeleteError": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так. Попробуйте ещё раз.",
    ),
    "healthDeleteStressBody": MessageLookupByLibrary.simpleMessage(
      "Это безвозвратно удалит все ваши показатели стресса и данные датчиков.",
    ),
    "healthDeleteStressButton": MessageLookupByLibrary.simpleMessage(
      "Удалить все данные о здоровье",
    ),
    "healthDeleteStressConfirm": MessageLookupByLibrary.simpleMessage(
      "Удалить всё",
    ),
    "healthDeleteStressTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить все данные о здоровье?",
    ),
    "healthEntryDeleteConfirm": MessageLookupByLibrary.simpleMessage("Удалить"),
    "healthEntryDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить запись?",
    ),
    "healthInsightsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "АНАЛИТИКА",
    ),
    "healthMoodAllDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Все данные о настроении удалены",
    ),
    "healthMoodDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Запись о настроении удалена",
    ),
    "healthMoodSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ИСТОРИЯ НАСТРОЕНИЯ",
    ),
    "healthNoInsights": MessageLookupByLibrary.simpleMessage(
      "Пока нет аналитики",
    ),
    "healthNoInsightsBody": MessageLookupByLibrary.simpleMessage(
      "Выполните check-in с данными умных часов, чтобы увидеть показатели стресса.",
    ),
    "healthNoMoodEntries": MessageLookupByLibrary.simpleMessage(
      "Нет записей о настроении на этой неделе",
    ),
    "healthOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Мои данные о здоровье",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ",
    ),
    "healthStressComputedAt": m7,
    "healthStressDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Все данные о здоровье удалены",
    ),
    "healthStressScoreLabel": m8,
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage(
      "С возвращением,",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Обзор настроения",
    ),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage("ЭТА НЕДЕЛЯ"),
    "navAgenda": MessageLookupByLibrary.simpleMessage("Расписание"),
    "navChats": MessageLookupByLibrary.simpleMessage("Чаты"),
    "navHome": MessageLookupByLibrary.simpleMessage("Главная"),
    "navNetwork": MessageLookupByLibrary.simpleMessage("Моя Сеть"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Профиль"),
    "networkAccept": MessageLookupByLibrary.simpleMessage("Принять"),
    "networkAcceptedSuccess": MessageLookupByLibrary.simpleMessage(
      "Связь принята",
    ),
    "networkAddSomeone": MessageLookupByLibrary.simpleMessage(
      "Добавить кого-то",
    ),
    "networkAddToNetwork": MessageLookupByLibrary.simpleMessage(
      "Добавить в сеть",
    ),
    "networkBookAppointment": MessageLookupByLibrary.simpleMessage(
      "Записаться на приём",
    ),
    "networkBookAppointmentSubtitle": MessageLookupByLibrary.simpleMessage(
      "Просмотр доступных слотов",
    ),
    "networkConnections": MessageLookupByLibrary.simpleMessage("Связи"),
    "networkDeclinedSuccess": MessageLookupByLibrary.simpleMessage(
      "Запрос отклонён",
    ),
    "networkDeny": MessageLookupByLibrary.simpleMessage("Отклонить"),
    "networkEmptyConnections": MessageLookupByLibrary.simpleMessage(
      "Нет связей",
    ),
    "networkEmptyConnectionsBody": MessageLookupByLibrary.simpleMessage(
      "Отправьте запросы на связь, чтобы расширить сеть поддержки.",
    ),
    "networkEmptyIncoming": MessageLookupByLibrary.simpleMessage(
      "Нет входящих запросов",
    ),
    "networkEmptyRequests": MessageLookupByLibrary.simpleMessage(
      "Нет запросов",
    ),
    "networkEmptyRequestsBody": MessageLookupByLibrary.simpleMessage(
      "У вас нет входящих или исходящих запросов на связь.",
    ),
    "networkEmptySent": MessageLookupByLibrary.simpleMessage(
      "Нет ожидающих запросов",
    ),
    "networkErrorAlreadyConnected": MessageLookupByLibrary.simpleMessage(
      "Уже подключены или запрос уже на рассмотрении",
    ),
    "networkErrorCannotRemove": MessageLookupByLibrary.simpleMessage(
      "Не удаётся удалить эту связь. Это может быть известное ограничение сервера — попросите их удалить вас.",
    ),
    "networkErrorCannotSend": MessageLookupByLibrary.simpleMessage(
      "Не могу отправить запрос этому пользователю",
    ),
    "networkErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так. Попробуйте ещё раз.",
    ),
    "networkErrorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "Пользователь не найден",
    ),
    "networkGroupOther": MessageLookupByLibrary.simpleMessage("ДРУГИЕ"),
    "networkGroupSupport": MessageLookupByLibrary.simpleMessage(
      "СЕТЬ ПОДДЕРЖКИ",
    ),
    "networkGroupTherapists": MessageLookupByLibrary.simpleMessage("ТЕРАПЕВТЫ"),
    "networkGroupVeterans": MessageLookupByLibrary.simpleMessage("ВЕТЕРАНЫ"),
    "networkIncoming": MessageLookupByLibrary.simpleMessage("ВХОДЯЩИЕ"),
    "networkNoteHint": MessageLookupByLibrary.simpleMessage(
      "Добавьте личное сообщение...",
    ),
    "networkNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Заметка (необязательно)",
    ),
    "networkPendingLabel": MessageLookupByLibrary.simpleMessage("В ожидании"),
    "networkPrivacySettings": MessageLookupByLibrary.simpleMessage(
      "Настройки конфиденциальности",
    ),
    "networkPrivacySettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Управляйте доступом этого человека",
    ),
    "networkRemove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "networkRemoveBody": m9,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Удалить"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить из сети?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Удалено из сети",
    ),
    "networkRequestSentSuccess": m10,
    "networkRequests": MessageLookupByLibrary.simpleMessage("Запросы"),
    "networkRoleSupport": MessageLookupByLibrary.simpleMessage(
      "Сеть поддержки",
    ),
    "networkRoleTherapist": MessageLookupByLibrary.simpleMessage("Терапевт"),
    "networkRoleVeteran": MessageLookupByLibrary.simpleMessage("Ветеран"),
    "networkSendRequest": MessageLookupByLibrary.simpleMessage(
      "Отправить запрос",
    ),
    "networkSent": MessageLookupByLibrary.simpleMessage("ОТПРАВЛЕННЫЕ"),
    "networkTitle": MessageLookupByLibrary.simpleMessage("Моя Сеть"),
    "networkUsernameHint": MessageLookupByLibrary.simpleMessage(
      "например, ivan_ivanov",
    ),
    "networkUsernameLabel": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя",
    ),
    "networkUsernameRequired": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите имя пользователя",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "Как вы себя чувствуете? (макс. 500 символов)",
    ),
    "notesLabel": MessageLookupByLibrary.simpleMessage(
      "Заметки (необязательно)",
    ),
    "profileDeleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт",
    ),
    "profileDeleteError": m11,
    "profileDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите навсегда удалить свой аккаунт? Это действие необратимо, все данные будут утеряны.",
    ),
    "profileDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт",
    ),
    "profileEditAbout": MessageLookupByLibrary.simpleMessage("О себе"),
    "profileEditAboutHint": MessageLookupByLibrary.simpleMessage(
      "Подробнее о себе (макс. 500 символов)",
    ),
    "profileEditButton": MessageLookupByLibrary.simpleMessage(
      "Редактировать профиль",
    ),
    "profileEditCity": MessageLookupByLibrary.simpleMessage("Город"),
    "profileEditCountry": MessageLookupByLibrary.simpleMessage("Страна"),
    "profileEditFirstName": MessageLookupByLibrary.simpleMessage("Имя"),
    "profileEditFirstNameRequired": MessageLookupByLibrary.simpleMessage(
      "Имя обязательно",
    ),
    "profileEditIntroduction": MessageLookupByLibrary.simpleMessage(
      "Вступление",
    ),
    "profileEditIntroductionHint": MessageLookupByLibrary.simpleMessage(
      "Краткое описание того, кто вы",
    ),
    "profileEditLastName": MessageLookupByLibrary.simpleMessage("Фамилия"),
    "profileEditPhone": MessageLookupByLibrary.simpleMessage("Номер телефона"),
    "profileEditPhotoUrl": MessageLookupByLibrary.simpleMessage(
      "URL фото профиля",
    ),
    "profileEditPhotoUrlHint": MessageLookupByLibrary.simpleMessage(
      "Введите публичную ссылку на изображение",
    ),
    "profileEditPostalCode": MessageLookupByLibrary.simpleMessage(
      "Почтовый индекс",
    ),
    "profileEditRegion": MessageLookupByLibrary.simpleMessage("Регион / Штат"),
    "profileEditSaveButton": MessageLookupByLibrary.simpleMessage(
      "Сохранить изменения",
    ),
    "profileEditSectionAddress": MessageLookupByLibrary.simpleMessage("АДРЕС"),
    "profileEditSectionBio": MessageLookupByLibrary.simpleMessage("О СЕБЕ"),
    "profileEditSectionContact": MessageLookupByLibrary.simpleMessage(
      "КОНТАКТЫ",
    ),
    "profileEditSectionName": MessageLookupByLibrary.simpleMessage("ИМЯ"),
    "profileEditSectionPhoto": MessageLookupByLibrary.simpleMessage("ФОТО"),
    "profileEditStreet": MessageLookupByLibrary.simpleMessage("Улица"),
    "profileEditTitle": MessageLookupByLibrary.simpleMessage(
      "Редактировать профиль",
    ),
    "profileLabelAddress": MessageLookupByLibrary.simpleMessage("Адрес"),
    "profileLabelEmail": MessageLookupByLibrary.simpleMessage("Эл. почта"),
    "profileLabelPhone": MessageLookupByLibrary.simpleMessage("Телефон"),
    "profileLabelPrivacy": MessageLookupByLibrary.simpleMessage(
      "Конфиденциальность",
    ),
    "profilePrivateAccount": MessageLookupByLibrary.simpleMessage(
      "Закрытый аккаунт",
    ),
    "profilePublicAccount": MessageLookupByLibrary.simpleMessage(
      "Открытый аккаунт",
    ),
    "profileSectionAbout": MessageLookupByLibrary.simpleMessage("О СЕБЕ"),
    "profileSectionIntroduction": MessageLookupByLibrary.simpleMessage(
      "ВВЕДЕНИЕ",
    ),
    "profileSignOut": MessageLookupByLibrary.simpleMessage("Выйти"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileUpdateError": m12,
    "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно обновлён",
    ),
    "profileUsernameCopied": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя скопировано",
    ),
    "quickActionsBookSession": MessageLookupByLibrary.simpleMessage(
      "Записаться\nна сеанс",
    ),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Линия\nкризиса",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Написать\nдругу",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "БЫСТРЫЕ ДЕЙСТВИЯ",
    ),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Отправить"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("ещё"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "МОЯ СЕТЬ ПОДДЕРЖКИ",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Услуги Сверх Службы"),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("ПРЕДСТОЯЩЕЕ"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Используйте нашу веб-версию",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "Безопасное пространство для тех, кто служил. Endurance соединяет вас с людьми, которые важны для вас больше всего, на ваших условиях, в вашем темпе.",
    ),
  };
}
