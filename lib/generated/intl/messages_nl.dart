// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a nl locale. All the
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
  String get localeName => 'nl';

  static String m2(score) => "gem. ${score} vandaag";

  static String m3(score) => "${score}/10";

  static String m4(count) => "${count}u geleden";

  static String m5(count) => "${count}m geleden";

  static String m6(score) => "Stemming: ${score}/10";

  static String m7(date) => "Berekend op ${date}";

  static String m8(score) => "Stressscore: ${score}";

  static String m9(name) => "${name} wordt verwijderd uit uw steunnetwerk.";

  static String m10(username) => "Verzoek verzonden naar @${username}";

  static String m11(error) => "Fout bij verwijderen: ${error}";

  static String m12(error) => "Fout bij bijwerken: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage("Toegang Beperkt"),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Sorry, toegang tot Endurance is voorbehouden aan geverifieerde veteranen. Uw account heeft momenteel niet de vereiste toegang.",
    ),
    "agendaAddAvailability": MessageLookupByLibrary.simpleMessage(
      "Beschikbaarheid toevoegen",
    ),
    "agendaAddSlotButton": MessageLookupByLibrary.simpleMessage("Toevoegen"),
    "agendaAddSlotDuration": MessageLookupByLibrary.simpleMessage("Duur"),
    "agendaAddSlotError": MessageLookupByLibrary.simpleMessage(
      "Kon beschikbaarheid niet toevoegen. Probeer het opnieuw.",
    ),
    "agendaAddSlotRecurring": MessageLookupByLibrary.simpleMessage(
      "Wekelijks herhalen",
    ),
    "agendaAddSlotRecurringHint": MessageLookupByLibrary.simpleMessage(
      "Maakt beschikbaarheid voor de komende 8 weken",
    ),
    "agendaAddSlotStartTime": MessageLookupByLibrary.simpleMessage("Starttijd"),
    "agendaAddSlotSuccess": MessageLookupByLibrary.simpleMessage(
      "Beschikbaarheid toegevoegd!",
    ),
    "agendaBookButton": MessageLookupByLibrary.simpleMessage("Afspraak boeken"),
    "agendaBookError": MessageLookupByLibrary.simpleMessage(
      "Kon slot niet boeken. Probeer het opnieuw.",
    ),
    "agendaBookedSuccess": MessageLookupByLibrary.simpleMessage(
      "Afspraak geboekt!",
    ),
    "agendaCancelBody": MessageLookupByLibrary.simpleMessage(
      "Dit maakt het tijdslot vrij voor anderen.",
    ),
    "agendaCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "Afspraak annuleren",
    ),
    "agendaCancelTitle": MessageLookupByLibrary.simpleMessage(
      "Afspraak annuleren?",
    ),
    "agendaCancelledSuccess": MessageLookupByLibrary.simpleMessage(
      "Afspraak geannuleerd",
    ),
    "agendaEmptyAvailability": MessageLookupByLibrary.simpleMessage(
      "Geen beschikbaarheid ingesteld",
    ),
    "agendaEmptyAvailabilityBody": MessageLookupByLibrary.simpleMessage(
      "Voeg tijdvensters toe voor uw netwerk.",
    ),
    "agendaEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Boek een slot met iemand uit uw ondersteuningsnetwerk.",
    ),
    "agendaEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "Nog geen afspraken",
    ),
    "agendaExportCalendar": MessageLookupByLibrary.simpleMessage(
      "Agenda exporteren",
    ),
    "agendaExportError": MessageLookupByLibrary.simpleMessage(
      "Kon agenda niet exporteren. Probeer het opnieuw.",
    ),
    "agendaExportSuccess": MessageLookupByLibrary.simpleMessage(
      "Agenda geëxporteerd!",
    ),
    "agendaNoAppointmentsBody": MessageLookupByLibrary.simpleMessage(
      "Boek een slot via uw netwerk om te beginnen.",
    ),
    "agendaNoSlots": MessageLookupByLibrary.simpleMessage(
      "Geen beschikbare slots de komende 30 dagen",
    ),
    "agendaPast": MessageLookupByLibrary.simpleMessage("VERLEDEN"),
    "agendaSlotAvailable": MessageLookupByLibrary.simpleMessage("Beschikbaar"),
    "agendaSlotBooked": MessageLookupByLibrary.simpleMessage("Geboekt"),
    "agendaSlotDeleteAllSeries": MessageLookupByLibrary.simpleMessage(
      "Alle toekomstige",
    ),
    "agendaSlotDeleteBody": MessageLookupByLibrary.simpleMessage(
      "Dit tijdvenster wordt verwijderd.",
    ),
    "agendaSlotDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Verwijderen",
    ),
    "agendaSlotDeleteSeriesTitle": MessageLookupByLibrary.simpleMessage(
      "Terugkerende beschikbaarheid verwijderen?",
    ),
    "agendaSlotDeleteThisOnly": MessageLookupByLibrary.simpleMessage(
      "Alleen deze",
    ),
    "agendaSlotDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Beschikbaarheid verwijderen?",
    ),
    "agendaSlotDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Beschikbaarheid verwijderd",
    ),
    "agendaTabAppointments": MessageLookupByLibrary.simpleMessage("Afspraken"),
    "agendaTabAvailability": MessageLookupByLibrary.simpleMessage(
      "Mijn beschikbaarheid",
    ),
    "agendaTitle": MessageLookupByLibrary.simpleMessage("Schema"),
    "agendaUpcoming": MessageLookupByLibrary.simpleMessage("AANKOMEND"),
    "agendaUpcomingNoAppointments": MessageLookupByLibrary.simpleMessage(
      "Geen aankomende afspraken",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Annuleren"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage(
      "Check-in toevoegen",
    ),
    "checkInAvgToday": m2,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Er is iets misgegaan. Probeer het opnieuw.",
    ),
    "checkInScoreLabel": m3,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Check-in ingediend!",
    ),
    "checkInTimeAgoHours": m4,
    "checkInTimeAgoMinutes": m5,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Check-in voltooien",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Check-in voltooid",
    ),
    "dailyCheckInDoneSubtitle": m6,
    "dailyCheckInPending": MessageLookupByLibrary.simpleMessage(
      "Hoe voel je je vandaag?",
    ),
    "dailyCheckInTitle": MessageLookupByLibrary.simpleMessage(
      "Dagelijkse check-in",
    ),
    "featureConnectedDesc": MessageLookupByLibrary.simpleMessage(
      "Neem contact op met vrienden, familie, therapeuten en medeveteranen op één veilige plek.",
    ),
    "featureConnectedTitle": MessageLookupByLibrary.simpleMessage(
      "Blijf verbonden",
    ),
    "featureMentalHealthDesc": MessageLookupByLibrary.simpleMessage(
      "Deel uw dagelijkse check-ins en smartwatchgegevens met uw therapeut, alleen als u dat wilt.",
    ),
    "featureMentalHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Inzichten in geestelijke gezondheid",
    ),
    "featurePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "Geen tracking, geen surveillance. U heeft volledige controle over wie wat ziet.",
    ),
    "featurePrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Uw privacy, altijd",
    ),
    "featureSharingDesc": MessageLookupByLibrary.simpleMessage(
      "U bepaalt precies wat uw ondersteuningsnetwerk kan zien. Toegang intrekken op elk moment.",
    ),
    "featureSharingTitle": MessageLookupByLibrary.simpleMessage(
      "Delen op basis van toestemming",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Aan de slag"),
    "healthCategoryHigh": MessageLookupByLibrary.simpleMessage("Hoog"),
    "healthCategoryLow": MessageLookupByLibrary.simpleMessage("Laag"),
    "healthCategoryModerate": MessageLookupByLibrary.simpleMessage("Matig"),
    "healthCategoryVeryHigh": MessageLookupByLibrary.simpleMessage("Zeer hoog"),
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Gezondheidsgegevens opnemen",
    ),
    "healthDeleteAllMoodBody": MessageLookupByLibrary.simpleMessage(
      "Dit verwijdert al uw stemmings-check-ins permanent.",
    ),
    "healthDeleteAllMoodButton": MessageLookupByLibrary.simpleMessage(
      "Verwijder alle stemmingsdata",
    ),
    "healthDeleteAllMoodConfirm": MessageLookupByLibrary.simpleMessage(
      "Alles verwijderen",
    ),
    "healthDeleteAllMoodTitle": MessageLookupByLibrary.simpleMessage(
      "Alle stemmingsdata verwijderen?",
    ),
    "healthDeleteError": MessageLookupByLibrary.simpleMessage(
      "Er is iets misgegaan. Probeer het opnieuw.",
    ),
    "healthDeleteStressBody": MessageLookupByLibrary.simpleMessage(
      "Dit verwijdert al uw stressscores en gezondheidsmetingen permanent.",
    ),
    "healthDeleteStressButton": MessageLookupByLibrary.simpleMessage(
      "Verwijder alle gezondheidsdata",
    ),
    "healthDeleteStressConfirm": MessageLookupByLibrary.simpleMessage(
      "Alles verwijderen",
    ),
    "healthDeleteStressTitle": MessageLookupByLibrary.simpleMessage(
      "Alle gezondheidsdata verwijderen?",
    ),
    "healthEntryDeleteConfirm": MessageLookupByLibrary.simpleMessage(
      "Verwijderen",
    ),
    "healthEntryDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Invoer verwijderen?",
    ),
    "healthInsightsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "INZICHTEN",
    ),
    "healthMoodAllDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Alle stemmingsdata verwijderd",
    ),
    "healthMoodDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Stemmingsinvoer verwijderd",
    ),
    "healthMoodSectionTitle": MessageLookupByLibrary.simpleMessage(
      "STEMMINGSGESCHIEDENIS",
    ),
    "healthNoInsights": MessageLookupByLibrary.simpleMessage(
      "Nog geen inzichten",
    ),
    "healthNoInsightsBody": MessageLookupByLibrary.simpleMessage(
      "Voltooi een check-in met uw smartwatchgegevens om stressinzichten te zien.",
    ),
    "healthNoMoodEntries": MessageLookupByLibrary.simpleMessage(
      "Geen stemmingsinvoer deze week",
    ),
    "healthOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Mijn gezondheidsdata",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Toegang verlenen",
    ),
    "healthStressComputedAt": m7,
    "healthStressDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Alle gezondheidsdata verwijderd",
    ),
    "healthStressScoreLabel": m8,
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage("Welkom terug,"),
    "logout": MessageLookupByLibrary.simpleMessage("Uitloggen"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Stemmingsoverzicht",
    ),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage("DEZE WEEK"),
    "navAgenda": MessageLookupByLibrary.simpleMessage("Schema"),
    "navChats": MessageLookupByLibrary.simpleMessage("Chats"),
    "navHome": MessageLookupByLibrary.simpleMessage("Thuis"),
    "navNetwork": MessageLookupByLibrary.simpleMessage("Mijn Netwerk"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Jij"),
    "networkAccept": MessageLookupByLibrary.simpleMessage("Accepteren"),
    "networkAcceptedSuccess": MessageLookupByLibrary.simpleMessage(
      "Verbinding geaccepteerd",
    ),
    "networkAddSomeone": MessageLookupByLibrary.simpleMessage(
      "Iemand toevoegen",
    ),
    "networkAddToNetwork": MessageLookupByLibrary.simpleMessage(
      "Toevoegen aan netwerk",
    ),
    "networkBookAppointment": MessageLookupByLibrary.simpleMessage(
      "Afspraak boeken",
    ),
    "networkBookAppointmentSubtitle": MessageLookupByLibrary.simpleMessage(
      "Beschikbare tijdslots bekijken",
    ),
    "networkConnections": MessageLookupByLibrary.simpleMessage("Verbindingen"),
    "networkDeclinedSuccess": MessageLookupByLibrary.simpleMessage(
      "Verzoek geweigerd",
    ),
    "networkDeny": MessageLookupByLibrary.simpleMessage("Weigeren"),
    "networkEmptyConnections": MessageLookupByLibrary.simpleMessage(
      "Nog geen verbindingen",
    ),
    "networkEmptyConnectionsBody": MessageLookupByLibrary.simpleMessage(
      "Stuur verbindingsverzoeken om uw steunnetwerk te laten groeien.",
    ),
    "networkEmptyIncoming": MessageLookupByLibrary.simpleMessage(
      "Geen inkomende verzoeken",
    ),
    "networkEmptyRequests": MessageLookupByLibrary.simpleMessage(
      "Geen verzoeken",
    ),
    "networkEmptyRequestsBody": MessageLookupByLibrary.simpleMessage(
      "U heeft geen inkomende of uitgaande verbindingsverzoeken.",
    ),
    "networkEmptySent": MessageLookupByLibrary.simpleMessage(
      "Geen openstaande verzoeken",
    ),
    "networkErrorAlreadyConnected": MessageLookupByLibrary.simpleMessage(
      "Al verbonden of er is al een verzoek in behandeling",
    ),
    "networkErrorCannotRemove": MessageLookupByLibrary.simpleMessage(
      "Kan deze verbinding niet verwijderen. Dit kan een bekende serverbeperking zijn — vraag hen om u te verwijderen.",
    ),
    "networkErrorCannotSend": MessageLookupByLibrary.simpleMessage(
      "Kan geen verzoek sturen naar deze gebruiker",
    ),
    "networkErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Er is iets misgegaan. Probeer het opnieuw.",
    ),
    "networkErrorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "Gebruiker niet gevonden",
    ),
    "networkGroupOther": MessageLookupByLibrary.simpleMessage("OVERIG"),
    "networkGroupSupport": MessageLookupByLibrary.simpleMessage("STEUNNETWERK"),
    "networkGroupTherapists": MessageLookupByLibrary.simpleMessage(
      "THERAPEUTEN",
    ),
    "networkGroupVeterans": MessageLookupByLibrary.simpleMessage("VETERANEN"),
    "networkIncoming": MessageLookupByLibrary.simpleMessage("INKOMEND"),
    "networkNoteHint": MessageLookupByLibrary.simpleMessage(
      "Voeg een persoonlijk bericht toe...",
    ),
    "networkNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Notitie (optioneel)",
    ),
    "networkPendingLabel": MessageLookupByLibrary.simpleMessage(
      "In behandeling",
    ),
    "networkPrivacySettings": MessageLookupByLibrary.simpleMessage(
      "Privacyinstellingen",
    ),
    "networkPrivacySettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Beheer wat deze persoon kan zien",
    ),
    "networkRemove": MessageLookupByLibrary.simpleMessage("Verwijderen"),
    "networkRemoveBody": m9,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Verwijderen"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Verwijderen uit netwerk?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Verwijderd uit netwerk",
    ),
    "networkRequestSentSuccess": m10,
    "networkRequests": MessageLookupByLibrary.simpleMessage("Verzoeken"),
    "networkRoleSupport": MessageLookupByLibrary.simpleMessage("Steunnetwerk"),
    "networkRoleTherapist": MessageLookupByLibrary.simpleMessage("Therapeut"),
    "networkRoleVeteran": MessageLookupByLibrary.simpleMessage("Veteraan"),
    "networkSendRequest": MessageLookupByLibrary.simpleMessage(
      "Verzoek verzenden",
    ),
    "networkSent": MessageLookupByLibrary.simpleMessage("VERZONDEN"),
    "networkTitle": MessageLookupByLibrary.simpleMessage("Mijn Netwerk"),
    "networkUsernameHint": MessageLookupByLibrary.simpleMessage(
      "bijv. jan_janssen",
    ),
    "networkUsernameLabel": MessageLookupByLibrary.simpleMessage(
      "Gebruikersnaam",
    ),
    "networkUsernameRequired": MessageLookupByLibrary.simpleMessage(
      "Voer een gebruikersnaam in",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "Hoe voel je je? (max. 500 tekens)",
    ),
    "notesLabel": MessageLookupByLibrary.simpleMessage("Notities (optioneel)"),
    "profileDeleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Account verwijderen",
    ),
    "profileDeleteError": m11,
    "profileDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "Weet u zeker dat u uw account permanent wilt verwijderen? Deze actie kan niet ongedaan worden gemaakt en al uw gegevens gaan verloren.",
    ),
    "profileDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Account verwijderen",
    ),
    "profileEditAbout": MessageLookupByLibrary.simpleMessage("Over mij"),
    "profileEditAboutHint": MessageLookupByLibrary.simpleMessage(
      "Meer details over jezelf (max. 500 tekens)",
    ),
    "profileEditButton": MessageLookupByLibrary.simpleMessage(
      "Profiel bewerken",
    ),
    "profileEditCity": MessageLookupByLibrary.simpleMessage("Stad"),
    "profileEditCountry": MessageLookupByLibrary.simpleMessage("Land"),
    "profileEditFirstName": MessageLookupByLibrary.simpleMessage("Voornaam"),
    "profileEditFirstNameRequired": MessageLookupByLibrary.simpleMessage(
      "Voornaam is verplicht",
    ),
    "profileEditIntroduction": MessageLookupByLibrary.simpleMessage(
      "Introductie",
    ),
    "profileEditIntroductionHint": MessageLookupByLibrary.simpleMessage(
      "Een korte introductie over wie je bent",
    ),
    "profileEditLastName": MessageLookupByLibrary.simpleMessage("Achternaam"),
    "profileEditPhone": MessageLookupByLibrary.simpleMessage("Telefoonnummer"),
    "profileEditPhotoUrl": MessageLookupByLibrary.simpleMessage(
      "Profielfoto-URL",
    ),
    "profileEditPhotoUrlHint": MessageLookupByLibrary.simpleMessage(
      "Voer een openbare afbeeldings-URL in",
    ),
    "profileEditPostalCode": MessageLookupByLibrary.simpleMessage("Postcode"),
    "profileEditRegion": MessageLookupByLibrary.simpleMessage("Regio / Staat"),
    "profileEditSaveButton": MessageLookupByLibrary.simpleMessage(
      "Wijzigingen opslaan",
    ),
    "profileEditSectionAddress": MessageLookupByLibrary.simpleMessage("ADRES"),
    "profileEditSectionBio": MessageLookupByLibrary.simpleMessage("BIO"),
    "profileEditSectionContact": MessageLookupByLibrary.simpleMessage(
      "CONTACT",
    ),
    "profileEditSectionName": MessageLookupByLibrary.simpleMessage("NAAM"),
    "profileEditSectionPhoto": MessageLookupByLibrary.simpleMessage("FOTO"),
    "profileEditStreet": MessageLookupByLibrary.simpleMessage("Straat"),
    "profileEditTitle": MessageLookupByLibrary.simpleMessage(
      "Profiel bewerken",
    ),
    "profileLabelAddress": MessageLookupByLibrary.simpleMessage("Adres"),
    "profileLabelEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
    "profileLabelPhone": MessageLookupByLibrary.simpleMessage("Telefoon"),
    "profileLabelPrivacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "profilePrivateAccount": MessageLookupByLibrary.simpleMessage(
      "Privéaccount",
    ),
    "profilePublicAccount": MessageLookupByLibrary.simpleMessage(
      "Openbaar account",
    ),
    "profileSectionAbout": MessageLookupByLibrary.simpleMessage("OVER MIJ"),
    "profileSectionIntroduction": MessageLookupByLibrary.simpleMessage(
      "INTRODUCTIE",
    ),
    "profileSignOut": MessageLookupByLibrary.simpleMessage("Uitloggen"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profiel"),
    "profileUpdateError": m12,
    "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profiel succesvol bijgewerkt",
    ),
    "profileUsernameCopied": MessageLookupByLibrary.simpleMessage(
      "Gebruikersnaam gekopieerd naar klembord",
    ),
    "quickActionsBookSession": MessageLookupByLibrary.simpleMessage(
      "Sessie\nboeken",
    ),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Crisis-\nlijn",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Bericht\nVriend",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "SNELLE ACTIES",
    ),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Indienen"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("meer"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "MIJN STEUNNETWERK",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Diensten Boven Dienst"),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("AANKOMEND"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Gebruik onze webversie",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "Een veilige plek gebouwd voor degenen die gediend hebben. Endurance verbindt u met de mensen die er het meest toe doen, op uw eigen voorwaarden, in uw eigen tempo.",
    ),
  };
}
