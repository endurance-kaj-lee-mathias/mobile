// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(time) => "Unread since ${time}";

  static String m1(message) => "You: ${message}";

  static String m2(score) => "avg ${score} today";

  static String m3(score) => "${score}/10";

  static String m4(count) => "${count}h ago";

  static String m5(count) => "${count}m ago";

  static String m6(score) => "Mood score: ${score}/10";

  static String m7(date) => "Computed ${date}";

  static String m8(score) => "Stress score: ${score}";

  static String m9(name) =>
      "${name} will be removed from your support network.";

  static String m10(username) => "Request sent to @${username}";

  static String m11(error) => "Error deleting account: ${error}";

  static String m12(error) => "Error updating profile: ${error}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage(
      "Access Restricted",
    ),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Sorry, access to Endurance is reserved for verified veterans. Your account does not currently have the required access.",
    ),
    "agendaAddAvailability": MessageLookupByLibrary.simpleMessage(
      "Add Availability",
    ),
    "agendaAddSlotButton": MessageLookupByLibrary.simpleMessage("Add"),
    "agendaAddSlotDuration": MessageLookupByLibrary.simpleMessage("Duration"),
    "agendaAddSlotError": MessageLookupByLibrary.simpleMessage(
      "Could not add availability. Please try again.",
    ),
    "agendaAddSlotRecurring": MessageLookupByLibrary.simpleMessage(
      "Repeat weekly",
    ),
    "agendaAddSlotRecurringHint": MessageLookupByLibrary.simpleMessage(
      "Creates availability for the next 8 weeks",
    ),
    "agendaAddSlotStartTime": MessageLookupByLibrary.simpleMessage(
      "Start Time",
    ),
    "agendaAddSlotSuccess": MessageLookupByLibrary.simpleMessage(
      "Availability added!",
    ),
    "agendaBookButton": MessageLookupByLibrary.simpleMessage(
      "Book Appointment",
    ),
    "agendaBookError": MessageLookupByLibrary.simpleMessage(
      "Could not book this slot. Please try again.",
    ),
    "agendaBookUrgentSlot": MessageLookupByLibrary.simpleMessage(
      "Book urgent slot",
    ),
    "agendaBookedSuccess": MessageLookupByLibrary.simpleMessage(
      "Appointment booked!",
    ),
    "agendaCancelBody": MessageLookupByLibrary.simpleMessage(
      "This will free up the time slot for others.",
    ),
    "agendaCancelConfirm": MessageLookupByLibrary.simpleMessage(
      "Cancel Appointment",
    ),
    "agendaCancelTitle": MessageLookupByLibrary.simpleMessage(
      "Cancel appointment?",
    ),
    "agendaCancelledSuccess": MessageLookupByLibrary.simpleMessage(
      "Appointment cancelled",
    ),
    "agendaEmptyAvailability": MessageLookupByLibrary.simpleMessage(
      "No availability set",
    ),
    "agendaEmptyAvailabilityBody": MessageLookupByLibrary.simpleMessage(
      "Add time windows for your network to book.",
    ),
    "agendaEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Book a slot with someone from your support network.",
    ),
    "agendaEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No appointments yet",
    ),
    "agendaExportCalendar": MessageLookupByLibrary.simpleMessage(
      "Export Calendar",
    ),
    "agendaExportError": MessageLookupByLibrary.simpleMessage(
      "Could not export calendar. Please try again.",
    ),
    "agendaExportSuccess": MessageLookupByLibrary.simpleMessage(
      "Calendar exported!",
    ),
    "agendaHighRiskBody": MessageLookupByLibrary.simpleMessage(
      "Your care team has flagged you as high risk. Please reach out.",
    ),
    "agendaHighRiskTitle": MessageLookupByLibrary.simpleMessage(
      "You may need support",
    ),
    "agendaNoAppointmentsBody": MessageLookupByLibrary.simpleMessage(
      "Book a slot from your network to get started.",
    ),
    "agendaNoSlots": MessageLookupByLibrary.simpleMessage(
      "No available slots in the next 30 days",
    ),
    "agendaNoUrgentSlots": MessageLookupByLibrary.simpleMessage(
      "No urgent slots available right now",
    ),
    "agendaPast": MessageLookupByLibrary.simpleMessage("PAST"),
    "agendaSlotAvailable": MessageLookupByLibrary.simpleMessage("Available"),
    "agendaSlotBooked": MessageLookupByLibrary.simpleMessage("Booked"),
    "agendaSlotDeleteAllSeries": MessageLookupByLibrary.simpleMessage(
      "All future occurrences",
    ),
    "agendaSlotDeleteBody": MessageLookupByLibrary.simpleMessage(
      "This time window will be removed.",
    ),
    "agendaSlotDeleteConfirm": MessageLookupByLibrary.simpleMessage("Remove"),
    "agendaSlotDeleteSeriesTitle": MessageLookupByLibrary.simpleMessage(
      "Remove recurring availability?",
    ),
    "agendaSlotDeleteThisOnly": MessageLookupByLibrary.simpleMessage(
      "Only this one",
    ),
    "agendaSlotDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Remove availability?",
    ),
    "agendaSlotDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Availability removed",
    ),
    "agendaTabAppointments": MessageLookupByLibrary.simpleMessage(
      "Appointments",
    ),
    "agendaTabAvailability": MessageLookupByLibrary.simpleMessage(
      "My Availability",
    ),
    "agendaTalkToTherapist": MessageLookupByLibrary.simpleMessage(
      "Talk to therapist",
    ),
    "agendaTitle": MessageLookupByLibrary.simpleMessage("Schedule"),
    "agendaUpcoming": MessageLookupByLibrary.simpleMessage("UPCOMING"),
    "agendaUpcomingNoAppointments": MessageLookupByLibrary.simpleMessage(
      "No upcoming appointments",
    ),
    "agendaUrgentAppointment": MessageLookupByLibrary.simpleMessage(
      "Urgent appointment",
    ),
    "agendaUrgentLabel": MessageLookupByLibrary.simpleMessage("Urgent"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "chatInputHint": MessageLookupByLibrary.simpleMessage("Message…"),
    "chatLoadingError": MessageLookupByLibrary.simpleMessage(
      "Could not open this chat. Please try again.",
    ),
    "chatOpenError": MessageLookupByLibrary.simpleMessage(
      "Could not start conversation. Please try again.",
    ),
    "chatSend": MessageLookupByLibrary.simpleMessage("Send"),
    "chatUnreadSince": m0,
    "chatsEmptyBody": MessageLookupByLibrary.simpleMessage(
      "Tap on someone in your support network to start a conversation.",
    ),
    "chatsEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No conversations yet",
    ),
    "chatsMessagePreviewYou": m1,
    "chatsNoMessages": MessageLookupByLibrary.simpleMessage("No messages yet"),
    "chatsSayHi": MessageLookupByLibrary.simpleMessage("Say hi! 👋"),
    "chatsToday": MessageLookupByLibrary.simpleMessage("Today"),
    "chatsYesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
    "chatsYou": MessageLookupByLibrary.simpleMessage("You"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage("Add check-in"),
    "checkInAvgToday": m2,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "checkInScoreLabel": m3,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Check-in submitted!",
    ),
    "checkInTimeAgoHours": m4,
    "checkInTimeAgoMinutes": m5,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Complete check-in",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Check-in complete",
    ),
    "dailyCheckInDoneSubtitle": m6,
    "dailyCheckInPending": MessageLookupByLibrary.simpleMessage(
      "How are you feeling today?",
    ),
    "dailyCheckInTitle": MessageLookupByLibrary.simpleMessage("Daily Check-In"),
    "featureConnectedDesc": MessageLookupByLibrary.simpleMessage(
      "Reach out to friends, family, therapists and fellow veterans in one secure place.",
    ),
    "featureConnectedTitle": MessageLookupByLibrary.simpleMessage(
      "Stay connected",
    ),
    "featureMentalHealthDesc": MessageLookupByLibrary.simpleMessage(
      "Share your daily check-ins and smartwatch data with your therapist, only if you choose to.",
    ),
    "featureMentalHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Mental health insights",
    ),
    "featurePrivacyDesc": MessageLookupByLibrary.simpleMessage(
      "No tracking, no surveillance. You are in full control of who sees what.",
    ),
    "featurePrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Your privacy, always",
    ),
    "featureSharingDesc": MessageLookupByLibrary.simpleMessage(
      "You decide exactly what your support network can see. Revoke access any time.",
    ),
    "featureSharingTitle": MessageLookupByLibrary.simpleMessage(
      "Permission-based sharing",
    ),
    "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "healthCategoryHigh": MessageLookupByLibrary.simpleMessage("High"),
    "healthCategoryLow": MessageLookupByLibrary.simpleMessage("Low"),
    "healthCategoryModerate": MessageLookupByLibrary.simpleMessage("Moderate"),
    "healthCategoryVeryHigh": MessageLookupByLibrary.simpleMessage("Very High"),
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Include health data",
    ),
    "healthDeleteAllMoodBody": MessageLookupByLibrary.simpleMessage(
      "This will permanently remove all your mood check-in entries. This action cannot be undone.",
    ),
    "healthDeleteAllMoodButton": MessageLookupByLibrary.simpleMessage(
      "Delete all mood data",
    ),
    "healthDeleteAllMoodConfirm": MessageLookupByLibrary.simpleMessage(
      "Delete All",
    ),
    "healthDeleteAllMoodTitle": MessageLookupByLibrary.simpleMessage(
      "Delete all mood data?",
    ),
    "healthDeleteError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "healthDeleteStressBody": MessageLookupByLibrary.simpleMessage(
      "This will permanently remove all your stress scores and health samples. This action cannot be undone.",
    ),
    "healthDeleteStressButton": MessageLookupByLibrary.simpleMessage(
      "Delete all health data",
    ),
    "healthDeleteStressConfirm": MessageLookupByLibrary.simpleMessage(
      "Delete All",
    ),
    "healthDeleteStressTitle": MessageLookupByLibrary.simpleMessage(
      "Delete all health data?",
    ),
    "healthEntryDeleteConfirm": MessageLookupByLibrary.simpleMessage("Delete"),
    "healthEntryDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Delete entry?",
    ),
    "healthInsightsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "INSIGHTS",
    ),
    "healthMoodAllDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "All mood data deleted",
    ),
    "healthMoodDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "Mood entry deleted",
    ),
    "healthMoodSectionTitle": MessageLookupByLibrary.simpleMessage(
      "MOOD HISTORY",
    ),
    "healthNoInsights": MessageLookupByLibrary.simpleMessage("No insights yet"),
    "healthNoInsightsBody": MessageLookupByLibrary.simpleMessage(
      "Complete a check-in with your smartwatch data to see stress insights here.",
    ),
    "healthNoMoodEntries": MessageLookupByLibrary.simpleMessage(
      "No mood entries this week",
    ),
    "healthOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "My Health Data",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Allow access",
    ),
    "healthStressComputedAt": m7,
    "healthStressDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "All health data deleted",
    ),
    "healthStressScoreLabel": m8,
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage("Welcome back,"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage("Mood Overview"),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage("THIS WEEK"),
    "navAgenda": MessageLookupByLibrary.simpleMessage("Schedule"),
    "navChats": MessageLookupByLibrary.simpleMessage("Chats"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navNetwork": MessageLookupByLibrary.simpleMessage("My Network"),
    "navProfile": MessageLookupByLibrary.simpleMessage("You"),
    "networkAccept": MessageLookupByLibrary.simpleMessage("Accept"),
    "networkAcceptedSuccess": MessageLookupByLibrary.simpleMessage(
      "Connection accepted",
    ),
    "networkAddSomeone": MessageLookupByLibrary.simpleMessage("Add Someone"),
    "networkAddToNetwork": MessageLookupByLibrary.simpleMessage(
      "Add to Network",
    ),
    "networkBookAppointment": MessageLookupByLibrary.simpleMessage(
      "Book Appointment",
    ),
    "networkBookAppointmentSubtitle": MessageLookupByLibrary.simpleMessage(
      "View available time slots",
    ),
    "networkConnections": MessageLookupByLibrary.simpleMessage("Connections"),
    "networkDeclinedSuccess": MessageLookupByLibrary.simpleMessage(
      "Request declined",
    ),
    "networkDeny": MessageLookupByLibrary.simpleMessage("Deny"),
    "networkEmptyConnections": MessageLookupByLibrary.simpleMessage(
      "No connections yet",
    ),
    "networkEmptyConnectionsBody": MessageLookupByLibrary.simpleMessage(
      "Send connection requests to grow your support network.",
    ),
    "networkEmptyIncoming": MessageLookupByLibrary.simpleMessage(
      "No incoming requests",
    ),
    "networkEmptyRequests": MessageLookupByLibrary.simpleMessage("No requests"),
    "networkEmptyRequestsBody": MessageLookupByLibrary.simpleMessage(
      "You have no incoming or outgoing connection requests.",
    ),
    "networkEmptySent": MessageLookupByLibrary.simpleMessage(
      "No pending requests",
    ),
    "networkErrorAlreadyConnected": MessageLookupByLibrary.simpleMessage(
      "Already connected or a request is already pending",
    ),
    "networkErrorCannotRemove": MessageLookupByLibrary.simpleMessage(
      "Cannot remove this connection. This may be a known server limitation — ask them to remove you instead.",
    ),
    "networkErrorCannotSend": MessageLookupByLibrary.simpleMessage(
      "Cannot send a request to this user",
    ),
    "networkErrorGeneric": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "networkErrorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "User not found",
    ),
    "networkGroupOther": MessageLookupByLibrary.simpleMessage("OTHER"),
    "networkGroupSupport": MessageLookupByLibrary.simpleMessage(
      "SUPPORT NETWORK",
    ),
    "networkGroupTherapists": MessageLookupByLibrary.simpleMessage(
      "THERAPISTS",
    ),
    "networkGroupVeterans": MessageLookupByLibrary.simpleMessage("VETERANS"),
    "networkIncoming": MessageLookupByLibrary.simpleMessage("INCOMING"),
    "networkNoteHint": MessageLookupByLibrary.simpleMessage(
      "Add a personal message...",
    ),
    "networkNoteOptional": MessageLookupByLibrary.simpleMessage(
      "Note (optional)",
    ),
    "networkPendingLabel": MessageLookupByLibrary.simpleMessage("Pending"),
    "networkPrivacySettings": MessageLookupByLibrary.simpleMessage(
      "Privacy settings",
    ),
    "networkPrivacySettingsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Control what this person can see",
    ),
    "networkRemove": MessageLookupByLibrary.simpleMessage("Remove"),
    "networkRemoveBody": m9,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Remove"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Remove from network?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Removed from network",
    ),
    "networkRequestSentSuccess": m10,
    "networkRequests": MessageLookupByLibrary.simpleMessage("Requests"),
    "networkRoleSupport": MessageLookupByLibrary.simpleMessage(
      "Support Network",
    ),
    "networkRoleTherapist": MessageLookupByLibrary.simpleMessage("Therapist"),
    "networkRoleVeteran": MessageLookupByLibrary.simpleMessage("Veteran"),
    "networkSendRequest": MessageLookupByLibrary.simpleMessage("Send Request"),
    "networkSent": MessageLookupByLibrary.simpleMessage("SENT"),
    "networkTitle": MessageLookupByLibrary.simpleMessage("My Network"),
    "networkUsernameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. john_doe",
    ),
    "networkUsernameLabel": MessageLookupByLibrary.simpleMessage("Username"),
    "networkUsernameRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter a username",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "How are you feeling? (max 500 characters)",
    ),
    "notesLabel": MessageLookupByLibrary.simpleMessage("Notes (optional)"),
    "profileDeleteAccountButton": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "profileDeleteError": m11,
    "profileDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.",
    ),
    "profileDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Account",
    ),
    "profileEditAbout": MessageLookupByLibrary.simpleMessage("About"),
    "profileEditAboutHint": MessageLookupByLibrary.simpleMessage(
      "More details about you (max 500 characters)",
    ),
    "profileEditButton": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "profileEditCity": MessageLookupByLibrary.simpleMessage("City"),
    "profileEditCountry": MessageLookupByLibrary.simpleMessage("Country"),
    "profileEditFirstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "profileEditFirstNameRequired": MessageLookupByLibrary.simpleMessage(
      "First name is required",
    ),
    "profileEditIntroduction": MessageLookupByLibrary.simpleMessage(
      "Introduction",
    ),
    "profileEditIntroductionHint": MessageLookupByLibrary.simpleMessage(
      "A short intro to tell people who you are",
    ),
    "profileEditLastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "profileEditPhone": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "profileEditPhotoUrl": MessageLookupByLibrary.simpleMessage(
      "Profile Photo URL",
    ),
    "profileEditPhotoUrlHint": MessageLookupByLibrary.simpleMessage(
      "Enter a public image URL",
    ),
    "profileEditPostalCode": MessageLookupByLibrary.simpleMessage(
      "Postal Code",
    ),
    "profileEditRegion": MessageLookupByLibrary.simpleMessage("Region / State"),
    "profileEditSaveButton": MessageLookupByLibrary.simpleMessage(
      "Save Changes",
    ),
    "profileEditSectionAddress": MessageLookupByLibrary.simpleMessage(
      "ADDRESS",
    ),
    "profileEditSectionBio": MessageLookupByLibrary.simpleMessage("BIO"),
    "profileEditSectionContact": MessageLookupByLibrary.simpleMessage(
      "CONTACT",
    ),
    "profileEditSectionName": MessageLookupByLibrary.simpleMessage("NAME"),
    "profileEditSectionPhoto": MessageLookupByLibrary.simpleMessage("PHOTO"),
    "profileEditStreet": MessageLookupByLibrary.simpleMessage("Street"),
    "profileEditTitle": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "profileLabelAddress": MessageLookupByLibrary.simpleMessage("Address"),
    "profileLabelEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "profileLabelPhone": MessageLookupByLibrary.simpleMessage("Phone"),
    "profileLabelPrivacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "profilePrivateAccount": MessageLookupByLibrary.simpleMessage(
      "Private Account",
    ),
    "profilePublicAccount": MessageLookupByLibrary.simpleMessage(
      "Public Account",
    ),
    "profileSectionAbout": MessageLookupByLibrary.simpleMessage("ABOUT"),
    "profileSectionIntroduction": MessageLookupByLibrary.simpleMessage(
      "INTRODUCTION",
    ),
    "profileSignOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUpdateError": m12,
    "profileUpdateSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "profileUsernameCopied": MessageLookupByLibrary.simpleMessage(
      "Username copied to clipboard",
    ),
    "quickActionsBookSession": MessageLookupByLibrary.simpleMessage(
      "Book\nSession",
    ),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Crisis\nLine",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Message\nBuddy",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "QUICK ACTIONS",
    ),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Submit"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("more"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "MY SUPPORT NETWORK",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Services Beyond Service"),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("UPCOMING"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Use our web version instead",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "A safe space built for those who served. Endurance connects you with the people who matter most, on your own terms, at your own pace.",
    ),
  };
}
