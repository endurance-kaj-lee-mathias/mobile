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

  static String m0(score) => "avg ${score} today";

  static String m1(score) => "${score}/10";

  static String m2(count) => "${count}h ago";

  static String m3(count) => "${count}m ago";

  static String m4(score) => "Mood score: ${score}/10";

  static String m5(name) =>
      "${name} will be removed from your support network.";

  static String m6(username) => "Request sent to @${username}";

  static String m7(minutes) => "${minutes} min read";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accessRestricted": MessageLookupByLibrary.simpleMessage(
      "Access Restricted",
    ),
    "accessRestrictedBody": MessageLookupByLibrary.simpleMessage(
      "Sorry, access to Endurance is reserved for verified veterans. Your account does not currently have the required access.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Endurance"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "chatsSoon": MessageLookupByLibrary.simpleMessage("Chats — coming soon"),
    "checkInAddButton": MessageLookupByLibrary.simpleMessage("Add check-in"),
    "checkInAvgToday": m0,
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "checkInScoreLabel": m1,
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Check-in submitted!",
    ),
    "checkInTimeAgoHours": m2,
    "checkInTimeAgoMinutes": m3,
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Complete check-in",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Check-in complete",
    ),
    "dailyCheckInDoneSubtitle": m4,
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
    "healthDataIncluded": MessageLookupByLibrary.simpleMessage(
      "Health data will be included",
    ),
    "healthPermissionBody": MessageLookupByLibrary.simpleMessage(
      "Allow Endurance to read your health data (heart rate, steps, sleep) to enrich your check-in.",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Allow access",
    ),
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage("Welcome back,"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "moodOverviewTitle": MessageLookupByLibrary.simpleMessage("Mood Overview"),
    "moodTrendSectionTitle": MessageLookupByLibrary.simpleMessage("THIS WEEK"),
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
    "networkRemove": MessageLookupByLibrary.simpleMessage("Remove"),
    "networkRemoveBody": m5,
    "networkRemoveConfirm": MessageLookupByLibrary.simpleMessage("Remove"),
    "networkRemoveTitle": MessageLookupByLibrary.simpleMessage(
      "Remove from network?",
    ),
    "networkRemovedSuccess": MessageLookupByLibrary.simpleMessage(
      "Removed from network",
    ),
    "networkRequestSentSuccess": m6,
    "networkRequests": MessageLookupByLibrary.simpleMessage("Requests"),
    "networkRoleSupport": MessageLookupByLibrary.simpleMessage(
      "Support Network",
    ),
    "networkRoleTherapist": MessageLookupByLibrary.simpleMessage("Therapist"),
    "networkRoleVeteran": MessageLookupByLibrary.simpleMessage("Veteran"),
    "networkSendRequest": MessageLookupByLibrary.simpleMessage("Send Request"),
    "networkSent": MessageLookupByLibrary.simpleMessage("SENT"),
    "networkSoon": MessageLookupByLibrary.simpleMessage(
      "Network — coming soon",
    ),
    "networkTitle": MessageLookupByLibrary.simpleMessage("My Network"),
    "networkUsernameHint": MessageLookupByLibrary.simpleMessage(
      "e.g. john_doe",
    ),
    "networkUsernameLabel": MessageLookupByLibrary.simpleMessage("Username"),
    "networkUsernameRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter a username",
    ),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "How was your day? (max 500 characters)",
    ),
    "notesLabel": MessageLookupByLibrary.simpleMessage("Notes (optional)"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "quickActionsCrisisLine": MessageLookupByLibrary.simpleMessage(
      "Crisis\nLine",
    ),
    "quickActionsFindTherapist": MessageLookupByLibrary.simpleMessage(
      "Find\nTherapist",
    ),
    "quickActionsMessageBuddy": MessageLookupByLibrary.simpleMessage(
      "Message\nBuddy",
    ),
    "quickActionsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "QUICK ACTIONS",
    ),
    "resourceCategoryCommunity": MessageLookupByLibrary.simpleMessage(
      "Community",
    ),
    "resourceCategoryMentalHealth": MessageLookupByLibrary.simpleMessage(
      "Mental Health",
    ),
    "resourceCategoryPhysical": MessageLookupByLibrary.simpleMessage(
      "Physical",
    ),
    "resourceCategoryWellbeing": MessageLookupByLibrary.simpleMessage(
      "Wellbeing",
    ),
    "resourceReadTime": m7,
    "resourceTitle1": MessageLookupByLibrary.simpleMessage(
      "Managing Anxiety\nin Everyday Life",
    ),
    "resourceTitle2": MessageLookupByLibrary.simpleMessage(
      "Finding Your\nVeterans Group",
    ),
    "resourceTitle3": MessageLookupByLibrary.simpleMessage(
      "Sleep Techniques\nfor Veterans",
    ),
    "resourceTitle4": MessageLookupByLibrary.simpleMessage(
      "Exercise as a\nHealing Tool",
    ),
    "resourcesSectionTitle": MessageLookupByLibrary.simpleMessage("RESOURCES"),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Submit"),
    "supportNetworkMore": MessageLookupByLibrary.simpleMessage("more"),
    "supportNetworkSectionTitle": MessageLookupByLibrary.simpleMessage(
      "MY SUPPORT NETWORK",
    ),
    "tagline": MessageLookupByLibrary.simpleMessage("Services Beyond Service"),
    "upcomingAppointmentTime": MessageLookupByLibrary.simpleMessage(
      "Tomorrow · 14:00",
    ),
    "upcomingAppointmentTitle": MessageLookupByLibrary.simpleMessage(
      "Therapy Session",
    ),
    "upcomingAppointmentWith": MessageLookupByLibrary.simpleMessage(
      "with Dr. Sarah Mitchell",
    ),
    "upcomingSectionTitle": MessageLookupByLibrary.simpleMessage("UPCOMING"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Use our web version instead",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "A safe space built for those who served. Endurance connects you with the people who matter most, on your own terms, at your own pace.",
    ),
  };
}
