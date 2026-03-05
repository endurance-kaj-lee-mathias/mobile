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

  static String m0(score) => "Mood score: ${score}/10";

  static String m1(name) => "Welcome back, ${name}.";

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
    "checkInError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "checkInSubmitting": MessageLookupByLibrary.simpleMessage("Submitting…"),
    "checkInSuccess": MessageLookupByLibrary.simpleMessage(
      "Check-in submitted!",
    ),
    "dailyCheckInButton": MessageLookupByLibrary.simpleMessage(
      "Complete check-in",
    ),
    "dailyCheckInDone": MessageLookupByLibrary.simpleMessage(
      "Check-in complete",
    ),
    "dailyCheckInDoneSubtitle": m0,
    "dailyCheckInPending": MessageLookupByLibrary.simpleMessage(
      "How are you feeling today?",
    ),
    "dailyCheckInTitle": MessageLookupByLibrary.simpleMessage("Daily Check-In"),
    "dailyCheckInUpdateButton": MessageLookupByLibrary.simpleMessage("Update"),
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
    "healthPermissionBody": MessageLookupByLibrary.simpleMessage(
      "Allow Endurance to read your health data (heart rate, steps, sleep) to enrich your check-in.",
    ),
    "healthPermissionGrant": MessageLookupByLibrary.simpleMessage(
      "Allow access",
    ),
    "healthPermissionSkip": MessageLookupByLibrary.simpleMessage(
      "Skip for now",
    ),
    "healthPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Health data",
    ),
    "homeWelcome": m1,
    "homeWelcomePrefix": MessageLookupByLibrary.simpleMessage("Welcome back,"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "moodScoreLabel": MessageLookupByLibrary.simpleMessage("Mood score"),
    "navChats": MessageLookupByLibrary.simpleMessage("Chats"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navNetwork": MessageLookupByLibrary.simpleMessage("My Network"),
    "navProfile": MessageLookupByLibrary.simpleMessage("You"),
    "networkSoon": MessageLookupByLibrary.simpleMessage(
      "Network — coming soon",
    ),
    "networkTitle": MessageLookupByLibrary.simpleMessage("My Network"),
    "notesHint": MessageLookupByLibrary.simpleMessage(
      "How was your day? (max 500 characters)",
    ),
    "notesLabel": MessageLookupByLibrary.simpleMessage("Notes (optional)"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("Profile"),
    "submitLabel": MessageLookupByLibrary.simpleMessage("Submit"),
    "tagline": MessageLookupByLibrary.simpleMessage("Services Beyond Service"),
    "useWebVersion": MessageLookupByLibrary.simpleMessage(
      "Use our web version instead",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "A safe space built for those who served. Endurance connects you with the people who matter most, on your own terms, at your own pace.",
    ),
  };
}
