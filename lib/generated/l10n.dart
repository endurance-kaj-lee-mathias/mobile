// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Endurance`
  String get appTitle {
    return Intl.message('Endurance', name: 'appTitle', desc: '', args: []);
  }

  /// `Services Beyond Service`
  String get tagline {
    return Intl.message(
      'Services Beyond Service',
      name: 'tagline',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back,`
  String get homeWelcomePrefix {
    return Intl.message(
      'Welcome back,',
      name: 'homeWelcomePrefix',
      desc: '',
      args: [],
    );
  }

  /// `Access Restricted`
  String get accessRestricted {
    return Intl.message(
      'Access Restricted',
      name: 'accessRestricted',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, access to Endurance is reserved for verified veterans. Your account does not currently have the required access.`
  String get accessRestrictedBody {
    return Intl.message(
      'Sorry, access to Endurance is reserved for verified veterans. Your account does not currently have the required access.',
      name: 'accessRestrictedBody',
      desc: '',
      args: [],
    );
  }

  /// `Use our web version instead`
  String get useWebVersion {
    return Intl.message(
      'Use our web version instead',
      name: 'useWebVersion',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `A safe space built for those who served. Endurance connects you with the people who matter most, on your own terms, at your own pace.`
  String get welcomeDescription {
    return Intl.message(
      'A safe space built for those who served. Endurance connects you with the people who matter most, on your own terms, at your own pace.',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your privacy, always`
  String get featurePrivacyTitle {
    return Intl.message(
      'Your privacy, always',
      name: 'featurePrivacyTitle',
      desc: '',
      args: [],
    );
  }

  /// `No tracking, no surveillance. You are in full control of who sees what.`
  String get featurePrivacyDesc {
    return Intl.message(
      'No tracking, no surveillance. You are in full control of who sees what.',
      name: 'featurePrivacyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mental health insights`
  String get featureMentalHealthTitle {
    return Intl.message(
      'Mental health insights',
      name: 'featureMentalHealthTitle',
      desc: '',
      args: [],
    );
  }

  /// `Share your daily check-ins and smartwatch data with your therapist, only if you choose to.`
  String get featureMentalHealthDesc {
    return Intl.message(
      'Share your daily check-ins and smartwatch data with your therapist, only if you choose to.',
      name: 'featureMentalHealthDesc',
      desc: '',
      args: [],
    );
  }

  /// `Stay connected`
  String get featureConnectedTitle {
    return Intl.message(
      'Stay connected',
      name: 'featureConnectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reach out to friends, family, therapists and fellow veterans in one secure place.`
  String get featureConnectedDesc {
    return Intl.message(
      'Reach out to friends, family, therapists and fellow veterans in one secure place.',
      name: 'featureConnectedDesc',
      desc: '',
      args: [],
    );
  }

  /// `Permission-based sharing`
  String get featureSharingTitle {
    return Intl.message(
      'Permission-based sharing',
      name: 'featureSharingTitle',
      desc: '',
      args: [],
    );
  }

  /// `You decide exactly what your support network can see. Revoke access any time.`
  String get featureSharingDesc {
    return Intl.message(
      'You decide exactly what your support network can see. Revoke access any time.',
      name: 'featureSharingDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Home`
  String get navHome {
    return Intl.message('Home', name: 'navHome', desc: '', args: []);
  }

  /// `Chats`
  String get navChats {
    return Intl.message('Chats', name: 'navChats', desc: '', args: []);
  }

  /// `My Network`
  String get navNetwork {
    return Intl.message('My Network', name: 'navNetwork', desc: '', args: []);
  }

  /// `You`
  String get navProfile {
    return Intl.message('You', name: 'navProfile', desc: '', args: []);
  }

  /// `Chats — coming soon`
  String get chatsSoon {
    return Intl.message(
      'Chats — coming soon',
      name: 'chatsSoon',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTitle {
    return Intl.message('Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `My Network`
  String get networkTitle {
    return Intl.message('My Network', name: 'networkTitle', desc: '', args: []);
  }

  /// `Network — coming soon`
  String get networkSoon {
    return Intl.message(
      'Network — coming soon',
      name: 'networkSoon',
      desc: '',
      args: [],
    );
  }

  /// `Daily Check-In`
  String get dailyCheckInTitle {
    return Intl.message(
      'Daily Check-In',
      name: 'dailyCheckInTitle',
      desc: '',
      args: [],
    );
  }

  /// `How are you feeling today?`
  String get dailyCheckInPending {
    return Intl.message(
      'How are you feeling today?',
      name: 'dailyCheckInPending',
      desc: '',
      args: [],
    );
  }

  /// `Check-in complete`
  String get dailyCheckInDone {
    return Intl.message(
      'Check-in complete',
      name: 'dailyCheckInDone',
      desc: '',
      args: [],
    );
  }

  /// `Mood score: {score}/10`
  String dailyCheckInDoneSubtitle(int score) {
    return Intl.message(
      'Mood score: $score/10',
      name: 'dailyCheckInDoneSubtitle',
      desc: '',
      args: [score],
    );
  }

  /// `Complete check-in`
  String get dailyCheckInButton {
    return Intl.message(
      'Complete check-in',
      name: 'dailyCheckInButton',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get dailyCheckInUpdateButton {
    return Intl.message(
      'Update',
      name: 'dailyCheckInUpdateButton',
      desc: '',
      args: [],
    );
  }

  /// `Notes (optional)`
  String get notesLabel {
    return Intl.message(
      'Notes (optional)',
      name: 'notesLabel',
      desc: '',
      args: [],
    );
  }

  /// `How was your day? (max 500 characters)`
  String get notesHint {
    return Intl.message(
      'How was your day? (max 500 characters)',
      name: 'notesHint',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitLabel {
    return Intl.message('Submit', name: 'submitLabel', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message('Cancel', name: 'cancelLabel', desc: '', args: []);
  }

  /// `Allow Endurance to read your health data (heart rate, steps, sleep) to enrich your check-in.`
  String get healthPermissionBody {
    return Intl.message(
      'Allow Endurance to read your health data (heart rate, steps, sleep) to enrich your check-in.',
      name: 'healthPermissionBody',
      desc: '',
      args: [],
    );
  }

  /// `Allow access`
  String get healthPermissionGrant {
    return Intl.message(
      'Allow access',
      name: 'healthPermissionGrant',
      desc: '',
      args: [],
    );
  }

  /// `Health data will be included`
  String get healthDataIncluded {
    return Intl.message(
      'Health data will be included',
      name: 'healthDataIncluded',
      desc: '',
      args: [],
    );
  }

  /// `Check-in submitted!`
  String get checkInSuccess {
    return Intl.message(
      'Check-in submitted!',
      name: 'checkInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get checkInError {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'checkInError',
      desc: '',
      args: [],
    );
  }

  /// `QUICK ACTIONS`
  String get quickActionsSectionTitle {
    return Intl.message(
      'QUICK ACTIONS',
      name: 'quickActionsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Crisis\nLine`
  String get quickActionsCrisisLine {
    return Intl.message(
      'Crisis\nLine',
      name: 'quickActionsCrisisLine',
      desc: '',
      args: [],
    );
  }

  /// `Message\nBuddy`
  String get quickActionsMessageBuddy {
    return Intl.message(
      'Message\nBuddy',
      name: 'quickActionsMessageBuddy',
      desc: '',
      args: [],
    );
  }

  /// `Find\nTherapist`
  String get quickActionsFindTherapist {
    return Intl.message(
      'Find\nTherapist',
      name: 'quickActionsFindTherapist',
      desc: '',
      args: [],
    );
  }

  /// `UPCOMING`
  String get upcomingSectionTitle {
    return Intl.message(
      'UPCOMING',
      name: 'upcomingSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `MY SUPPORT NETWORK`
  String get supportNetworkSectionTitle {
    return Intl.message(
      'MY SUPPORT NETWORK',
      name: 'supportNetworkSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get supportNetworkMore {
    return Intl.message('more', name: 'supportNetworkMore', desc: '', args: []);
  }

  /// `THIS WEEK`
  String get moodTrendSectionTitle {
    return Intl.message(
      'THIS WEEK',
      name: 'moodTrendSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mood Overview`
  String get moodOverviewTitle {
    return Intl.message(
      'Mood Overview',
      name: 'moodOverviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `RESOURCES`
  String get resourcesSectionTitle {
    return Intl.message(
      'RESOURCES',
      name: 'resourcesSectionTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
