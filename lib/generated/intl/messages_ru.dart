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

  static String m0(score) => "ср. ${score} сегодня";

  static String m1(score) => "${score}/10";

  static String m2(count) => "${count} ч. назад";

  static String m3(count) => "${count} мин. назад";

  static String m4(score) => "Настроение: ${score}/10";

  static String m5(name) => "${name} будет удалён из вашей сети поддержки.";

  static String m6(username) => "Запрос отправлен @${username}";

  static String m7(error) => "Ошибка удаления аккаунта: ${error}";

  static String m8(error) => "Ошибка обновления профиля: ${error}";

  static String m9(minutes) => "${minutes} мин чтения";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage(
      "Доступ Ограничен",
    ),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Извините, доступ к Endurance зарезервирован для проверенных ветеранов. Ваша учётная запись в настоящее время не имеет необходимого доступа.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Отмена"),
    "chatsSoon": MessageLookupByLibrary.simpleMessage("Чаты — скоро"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage(
      "Добавить отметку",
    ),
    "checkInAvgToday": m0,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Что-то пошло не так. Повторите попытку.",
    ),
    "checkInScoreLabel": m1,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Отметка отправлена!",
    ),
    "checkInTimeAgoHours": m2,
    "checkInTimeAgoMinutes": m3,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Заполнить отметку",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Отметка выполнена",
    ),
    "dailyCheckInDoneSubtitle": m4,
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
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Данные о здоровье будут включены",
    ),
    "healthPermissionBody": MessageLookupByLibrary.simpleMessage(
      "Разрешите Endurance читать данные о здоровье (пульс, шаги, сон) для обогащения отметки.",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Разрешить доступ",
    ),
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage(
      "С возвращением,",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Обзор настроения",
    ),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage("ЭТА НЕДЕЛЯ"),
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
    "networkRemove": MessageLookupByLibrary.simpleMessage("Удалить"),
    "networkRemoveBody": m5,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Удалить"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Удалить из сети?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Удалено из сети",
    ),
    "networkRequestSentSuccess": m6,
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
    "networkSoon": MessageLookupByLibrary.simpleMessage("Сеть — скоро"),
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
    "profileDeleteError": m7,
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
    "profileUpdateError": m8,
    "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Профиль успешно обновлён",
    ),
    "profileUsernameCopied": MessageLookupByLibrary.simpleMessage(
      "Имя пользователя скопировано",
    ),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Линия\nкризиса",
    ),
    "quickActionsFindTherapist": MessageLookupByLibrary.simpleMessage(
      "Найти\nтерапевта",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Написать\nдругу",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "БЫСТРЫЕ ДЕЙСТВИЯ",
    ),
    "resourceCategoryCommunity": MessageLookupByLibrary.simpleMessage(
      "Сообщество",
    ),
    "resourceCategoryMentalHealth": MessageLookupByLibrary.simpleMessage(
      "Психическое здоровье",
    ),
    "resourceCategoryPhysical": MessageLookupByLibrary.simpleMessage(
      "Физическое",
    ),
    "resourceCategoryWellbeing": MessageLookupByLibrary.simpleMessage(
      "Благополучие",
    ),
    "resourceReadTime": m9,
    "resourceTitle1": MessageLookupByLibrary.simpleMessage(
      "Управление тревогой\nв повседневной жизни",
    ),
    "resourceTitle2": MessageLookupByLibrary.simpleMessage(
      "Найти\nсвою группу ветеранов",
    ),
    "resourceTitle3": MessageLookupByLibrary.simpleMessage(
      "Техники сна\nдля ветеранов",
    ),
    "resourceTitle4": MessageLookupByLibrary.simpleMessage(
      "Упражнения как\nинструмент исцеления",
    ),
    "resourcesSectionTitle": MessageLookupByLibrary.simpleMessage("РЕСУРСЫ"),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Отправить"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("ещё"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "МОЯ СЕТЬ ПОДДЕРЖКИ",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Услуги Сверх Службы"),
    "upcomingAppointmentTime": MessageLookupByLibrary.simpleMessage(
      "Завтра · 14:00",
    ),
    "upcomingAppointmentTitle": MessageLookupByLibrary.simpleMessage(
      "Сеанс терапии",
    ),
    "upcomingAppointmentWith": MessageLookupByLibrary.simpleMessage(
      "с Др. Сарой Митчелл",
    ),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("ПРЕДСТОЯЩЕЕ"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Используйте нашу веб-версию",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "Безопасное пространство для тех, кто служил. Endurance соединяет вас с людьми, которые важны для вас больше всего, на ваших условиях, в вашем темпе.",
    ),
  };
}
