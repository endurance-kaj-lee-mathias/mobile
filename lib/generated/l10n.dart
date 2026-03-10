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
    return Intl.message(
      'Endurance',
      name: 'appTitle',
      desc: 'The application name.',
      args: [],
    );
  }

  /// `Services Beyond Service`
  String get tagline {
    return Intl.message(
      'Services Beyond Service',
      name: 'tagline',
      desc: 'Tagline shown on the splash and welcome screens.',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Submit`
  String get submitLabel {
    return Intl.message('Submit', name: 'submitLabel', desc: '', args: []);
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message('Cancel', name: 'cancelLabel', desc: '', args: []);
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

  /// `Connections`
  String get networkConnections {
    return Intl.message(
      'Connections',
      name: 'networkConnections',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get networkRequests {
    return Intl.message(
      'Requests',
      name: 'networkRequests',
      desc: '',
      args: [],
    );
  }

  /// `SUPPORT NETWORK`
  String get networkGroupSupport {
    return Intl.message(
      'SUPPORT NETWORK',
      name: 'networkGroupSupport',
      desc: '',
      args: [],
    );
  }

  /// `THERAPISTS`
  String get networkGroupTherapists {
    return Intl.message(
      'THERAPISTS',
      name: 'networkGroupTherapists',
      desc: '',
      args: [],
    );
  }

  /// `VETERANS`
  String get networkGroupVeterans {
    return Intl.message(
      'VETERANS',
      name: 'networkGroupVeterans',
      desc: '',
      args: [],
    );
  }

  /// `OTHER`
  String get networkGroupOther {
    return Intl.message('OTHER', name: 'networkGroupOther', desc: '', args: []);
  }

  /// `Support Network`
  String get networkRoleSupport {
    return Intl.message(
      'Support Network',
      name: 'networkRoleSupport',
      desc: '',
      args: [],
    );
  }

  /// `Therapist`
  String get networkRoleTherapist {
    return Intl.message(
      'Therapist',
      name: 'networkRoleTherapist',
      desc: '',
      args: [],
    );
  }

  /// `Veteran`
  String get networkRoleVeteran {
    return Intl.message(
      'Veteran',
      name: 'networkRoleVeteran',
      desc: '',
      args: [],
    );
  }

  /// `Add to Network`
  String get networkAddToNetwork {
    return Intl.message(
      'Add to Network',
      name: 'networkAddToNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Add Someone`
  String get networkAddSomeone {
    return Intl.message(
      'Add Someone',
      name: 'networkAddSomeone',
      desc: '',
      args: [],
    );
  }

  /// `No connections yet`
  String get networkEmptyConnections {
    return Intl.message(
      'No connections yet',
      name: 'networkEmptyConnections',
      desc: '',
      args: [],
    );
  }

  /// `Send connection requests to grow your support network.`
  String get networkEmptyConnectionsBody {
    return Intl.message(
      'Send connection requests to grow your support network.',
      name: 'networkEmptyConnectionsBody',
      desc: '',
      args: [],
    );
  }

  /// `No requests`
  String get networkEmptyRequests {
    return Intl.message(
      'No requests',
      name: 'networkEmptyRequests',
      desc: '',
      args: [],
    );
  }

  /// `You have no incoming or outgoing connection requests.`
  String get networkEmptyRequestsBody {
    return Intl.message(
      'You have no incoming or outgoing connection requests.',
      name: 'networkEmptyRequestsBody',
      desc: '',
      args: [],
    );
  }

  /// `No incoming requests`
  String get networkEmptyIncoming {
    return Intl.message(
      'No incoming requests',
      name: 'networkEmptyIncoming',
      desc: '',
      args: [],
    );
  }

  /// `No pending requests`
  String get networkEmptySent {
    return Intl.message(
      'No pending requests',
      name: 'networkEmptySent',
      desc: '',
      args: [],
    );
  }

  /// `INCOMING`
  String get networkIncoming {
    return Intl.message(
      'INCOMING',
      name: 'networkIncoming',
      desc: '',
      args: [],
    );
  }

  /// `SENT`
  String get networkSent {
    return Intl.message('SENT', name: 'networkSent', desc: '', args: []);
  }

  /// `Remove`
  String get networkRemove {
    return Intl.message('Remove', name: 'networkRemove', desc: '', args: []);
  }

  /// `Remove from network?`
  String get networkRemoveTitle {
    return Intl.message(
      'Remove from network?',
      name: 'networkRemoveTitle',
      desc: '',
      args: [],
    );
  }

  /// `{name} will be removed from your support network.`
  String networkRemoveBody(String name) {
    return Intl.message(
      '$name will be removed from your support network.',
      name: 'networkRemoveBody',
      desc: '',
      args: [name],
    );
  }

  /// `Remove`
  String get networkRemoveConfirm {
    return Intl.message(
      'Remove',
      name: 'networkRemoveConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get networkAccept {
    return Intl.message('Accept', name: 'networkAccept', desc: '', args: []);
  }

  /// `Deny`
  String get networkDeny {
    return Intl.message('Deny', name: 'networkDeny', desc: '', args: []);
  }

  /// `Username`
  String get networkUsernameLabel {
    return Intl.message(
      'Username',
      name: 'networkUsernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. john_doe`
  String get networkUsernameHint {
    return Intl.message(
      'e.g. john_doe',
      name: 'networkUsernameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a username`
  String get networkUsernameRequired {
    return Intl.message(
      'Please enter a username',
      name: 'networkUsernameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Note (optional)`
  String get networkNoteOptional {
    return Intl.message(
      'Note (optional)',
      name: 'networkNoteOptional',
      desc: '',
      args: [],
    );
  }

  /// `Add a personal message...`
  String get networkNoteHint {
    return Intl.message(
      'Add a personal message...',
      name: 'networkNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `Send Request`
  String get networkSendRequest {
    return Intl.message(
      'Send Request',
      name: 'networkSendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get networkPendingLabel {
    return Intl.message(
      'Pending',
      name: 'networkPendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `Request sent to @{username}`
  String networkRequestSentSuccess(String username) {
    return Intl.message(
      'Request sent to @$username',
      name: 'networkRequestSentSuccess',
      desc: '',
      args: [username],
    );
  }

  /// `Removed from network`
  String get networkRemovedSuccess {
    return Intl.message(
      'Removed from network',
      name: 'networkRemovedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Connection accepted`
  String get networkAcceptedSuccess {
    return Intl.message(
      'Connection accepted',
      name: 'networkAcceptedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Request declined`
  String get networkDeclinedSuccess {
    return Intl.message(
      'Request declined',
      name: 'networkDeclinedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get networkErrorGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'networkErrorGeneric',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get networkErrorUserNotFound {
    return Intl.message(
      'User not found',
      name: 'networkErrorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Already connected or a request is already pending`
  String get networkErrorAlreadyConnected {
    return Intl.message(
      'Already connected or a request is already pending',
      name: 'networkErrorAlreadyConnected',
      desc: '',
      args: [],
    );
  }

  /// `Cannot send a request to this user`
  String get networkErrorCannotSend {
    return Intl.message(
      'Cannot send a request to this user',
      name: 'networkErrorCannotSend',
      desc: '',
      args: [],
    );
  }

  /// `Cannot remove this connection. This may be a known server limitation — ask them to remove you instead.`
  String get networkErrorCannotRemove {
    return Intl.message(
      'Cannot remove this connection. This may be a known server limitation — ask them to remove you instead.',
      name: 'networkErrorCannotRemove',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back,`
  String get homeWelcomePrefix {
    return Intl.message(
      'Welcome back,',
      name: 'homeWelcomePrefix',
      desc:
          'Greeting prefix on the home screen, followed by the user\'s first name.',
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
      desc:
          'Subtitle shown when check-in is complete, displaying the mood score.',
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

  /// `Add check-in`
  String get checkInAddButton {
    return Intl.message(
      'Add check-in',
      name: 'checkInAddButton',
      desc: '',
      args: [],
    );
  }

  /// `{score}/10`
  String checkInScoreLabel(int score) {
    return Intl.message(
      '$score/10',
      name: 'checkInScoreLabel',
      desc:
          'Inline mood score display (e.g. \'7/10\') shown in the check-in card.',
      args: [score],
    );
  }

  /// `{count}m ago`
  String checkInTimeAgoMinutes(int count) {
    return Intl.message(
      '${count}m ago',
      name: 'checkInTimeAgoMinutes',
      desc: 'How long ago the last check-in was, in minutes.',
      args: [count],
    );
  }

  /// `{count}h ago`
  String checkInTimeAgoHours(int count) {
    return Intl.message(
      '${count}h ago',
      name: 'checkInTimeAgoHours',
      desc: 'How long ago the last check-in was, in hours.',
      args: [count],
    );
  }

  /// `avg {score} today`
  String checkInAvgToday(String score) {
    return Intl.message(
      'avg $score today',
      name: 'checkInAvgToday',
      desc: 'Average mood score for today shown when multiple check-ins exist.',
      args: [score],
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

  /// `Therapy Session`
  String get upcomingAppointmentTitle {
    return Intl.message(
      'Therapy Session',
      name: 'upcomingAppointmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `with Dr. Sarah Mitchell`
  String get upcomingAppointmentWith {
    return Intl.message(
      'with Dr. Sarah Mitchell',
      name: 'upcomingAppointmentWith',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow · 14:00`
  String get upcomingAppointmentTime {
    return Intl.message(
      'Tomorrow · 14:00',
      name: 'upcomingAppointmentTime',
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

  /// `Mental Health`
  String get resourceCategoryMentalHealth {
    return Intl.message(
      'Mental Health',
      name: 'resourceCategoryMentalHealth',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get resourceCategoryCommunity {
    return Intl.message(
      'Community',
      name: 'resourceCategoryCommunity',
      desc: '',
      args: [],
    );
  }

  /// `Wellbeing`
  String get resourceCategoryWellbeing {
    return Intl.message(
      'Wellbeing',
      name: 'resourceCategoryWellbeing',
      desc: '',
      args: [],
    );
  }

  /// `Physical`
  String get resourceCategoryPhysical {
    return Intl.message(
      'Physical',
      name: 'resourceCategoryPhysical',
      desc: '',
      args: [],
    );
  }

  /// `Managing Anxiety\nin Everyday Life`
  String get resourceTitle1 {
    return Intl.message(
      'Managing Anxiety\nin Everyday Life',
      name: 'resourceTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Finding Your\nVeterans Group`
  String get resourceTitle2 {
    return Intl.message(
      'Finding Your\nVeterans Group',
      name: 'resourceTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Sleep Techniques\nfor Veterans`
  String get resourceTitle3 {
    return Intl.message(
      'Sleep Techniques\nfor Veterans',
      name: 'resourceTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Exercise as a\nHealing Tool`
  String get resourceTitle4 {
    return Intl.message(
      'Exercise as a\nHealing Tool',
      name: 'resourceTitle4',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} min read`
  String resourceReadTime(int minutes) {
    return Intl.message(
      '$minutes min read',
      name: 'resourceReadTime',
      desc: 'Read time label on a resource card.',
      args: [minutes],
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
