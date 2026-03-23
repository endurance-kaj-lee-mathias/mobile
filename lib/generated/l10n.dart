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

  /// `No conversations yet`
  String get chatsEmptyTitle {
    return Intl.message(
      'No conversations yet',
      name: 'chatsEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap on someone in your support network to start a conversation.`
  String get chatsEmptyBody {
    return Intl.message(
      'Tap on someone in your support network to start a conversation.',
      name: 'chatsEmptyBody',
      desc: '',
      args: [],
    );
  }

  /// `You: {message}`
  String chatsMessagePreviewYou(String message) {
    return Intl.message(
      'You: $message',
      name: 'chatsMessagePreviewYou',
      desc: '',
      args: [message],
    );
  }

  /// `No messages yet`
  String get chatsNoMessages {
    return Intl.message(
      'No messages yet',
      name: 'chatsNoMessages',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get chatsYou {
    return Intl.message('You', name: 'chatsYou', desc: '', args: []);
  }

  /// `Say hi! 👋`
  String get chatsSayHi {
    return Intl.message('Say hi! 👋', name: 'chatsSayHi', desc: '', args: []);
  }

  /// `Today`
  String get chatsToday {
    return Intl.message('Today', name: 'chatsToday', desc: '', args: []);
  }

  /// `Yesterday`
  String get chatsYesterday {
    return Intl.message(
      'Yesterday',
      name: 'chatsYesterday',
      desc: '',
      args: [],
    );
  }

  /// `Message…`
  String get chatInputHint {
    return Intl.message('Message…', name: 'chatInputHint', desc: '', args: []);
  }

  /// `Send`
  String get chatSend {
    return Intl.message('Send', name: 'chatSend', desc: '', args: []);
  }

  /// `Could not open this chat. Please try again.`
  String get chatLoadingError {
    return Intl.message(
      'Could not open this chat. Please try again.',
      name: 'chatLoadingError',
      desc: '',
      args: [],
    );
  }

  /// `Could not start conversation. Please try again.`
  String get chatOpenError {
    return Intl.message(
      'Could not start conversation. Please try again.',
      name: 'chatOpenError',
      desc: '',
      args: [],
    );
  }

  /// `Unread since {time}`
  String chatUnreadSince(String time) {
    return Intl.message(
      'Unread since $time',
      name: 'chatUnreadSince',
      desc: '',
      args: [time],
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

  /// `How are you feeling? (max 500 characters)`
  String get notesHint {
    return Intl.message(
      'How are you feeling? (max 500 characters)',
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

  /// `Allow access`
  String get healthPermissionGrant {
    return Intl.message(
      'Allow access',
      name: 'healthPermissionGrant',
      desc: '',
      args: [],
    );
  }

  /// `Include health data`
  String get healthDataIncluded {
    return Intl.message(
      'Include health data',
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

  /// `Book\nSession`
  String get quickActionsBookSession {
    return Intl.message(
      'Book\nSession',
      name: 'quickActionsBookSession',
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

  /// `INTRODUCTION`
  String get profileSectionIntroduction {
    return Intl.message(
      'INTRODUCTION',
      name: 'profileSectionIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `ABOUT`
  String get profileSectionAbout {
    return Intl.message(
      'ABOUT',
      name: 'profileSectionAbout',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profileLabelEmail {
    return Intl.message('Email', name: 'profileLabelEmail', desc: '', args: []);
  }

  /// `Phone`
  String get profileLabelPhone {
    return Intl.message('Phone', name: 'profileLabelPhone', desc: '', args: []);
  }

  /// `Privacy`
  String get profileLabelPrivacy {
    return Intl.message(
      'Privacy',
      name: 'profileLabelPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get profileLabelAddress {
    return Intl.message(
      'Address',
      name: 'profileLabelAddress',
      desc: '',
      args: [],
    );
  }

  /// `Private Account`
  String get profilePrivateAccount {
    return Intl.message(
      'Private Account',
      name: 'profilePrivateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Public Account`
  String get profilePublicAccount {
    return Intl.message(
      'Public Account',
      name: 'profilePublicAccount',
      desc: '',
      args: [],
    );
  }

  /// `Username copied to clipboard`
  String get profileUsernameCopied {
    return Intl.message(
      'Username copied to clipboard',
      name: 'profileUsernameCopied',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profileEditButton {
    return Intl.message(
      'Edit Profile',
      name: 'profileEditButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get profileSignOut {
    return Intl.message('Sign Out', name: 'profileSignOut', desc: '', args: []);
  }

  /// `Delete Account`
  String get profileDeleteAccountButton {
    return Intl.message(
      'Delete Account',
      name: 'profileDeleteAccountButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get profileDeleteTitle {
    return Intl.message(
      'Delete Account',
      name: 'profileDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.`
  String get profileDeleteMessage {
    return Intl.message(
      'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.',
      name: 'profileDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting account: {error}`
  String profileDeleteError(String error) {
    return Intl.message(
      'Error deleting account: $error',
      name: 'profileDeleteError',
      desc: '',
      args: [error],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdateSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile: {error}`
  String profileUpdateError(String error) {
    return Intl.message(
      'Error updating profile: $error',
      name: 'profileUpdateError',
      desc: '',
      args: [error],
    );
  }

  /// `Edit Profile`
  String get profileEditTitle {
    return Intl.message(
      'Edit Profile',
      name: 'profileEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get profileEditSaveButton {
    return Intl.message(
      'Save Changes',
      name: 'profileEditSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `NAME`
  String get profileEditSectionName {
    return Intl.message(
      'NAME',
      name: 'profileEditSectionName',
      desc: '',
      args: [],
    );
  }

  /// `CONTACT`
  String get profileEditSectionContact {
    return Intl.message(
      'CONTACT',
      name: 'profileEditSectionContact',
      desc: '',
      args: [],
    );
  }

  /// `ADDRESS`
  String get profileEditSectionAddress {
    return Intl.message(
      'ADDRESS',
      name: 'profileEditSectionAddress',
      desc: '',
      args: [],
    );
  }

  /// `BIO`
  String get profileEditSectionBio {
    return Intl.message(
      'BIO',
      name: 'profileEditSectionBio',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get profileEditFirstName {
    return Intl.message(
      'First Name',
      name: 'profileEditFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get profileEditLastName {
    return Intl.message(
      'Last Name',
      name: 'profileEditLastName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get profileEditPhone {
    return Intl.message(
      'Phone Number',
      name: 'profileEditPhone',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get profileEditStreet {
    return Intl.message(
      'Street',
      name: 'profileEditStreet',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get profileEditCity {
    return Intl.message('City', name: 'profileEditCity', desc: '', args: []);
  }

  /// `Region / State`
  String get profileEditRegion {
    return Intl.message(
      'Region / State',
      name: 'profileEditRegion',
      desc: '',
      args: [],
    );
  }

  /// `Postal Code`
  String get profileEditPostalCode {
    return Intl.message(
      'Postal Code',
      name: 'profileEditPostalCode',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get profileEditCountry {
    return Intl.message(
      'Country',
      name: 'profileEditCountry',
      desc: '',
      args: [],
    );
  }

  /// `Introduction`
  String get profileEditIntroduction {
    return Intl.message(
      'Introduction',
      name: 'profileEditIntroduction',
      desc: '',
      args: [],
    );
  }

  /// `A short intro to tell people who you are`
  String get profileEditIntroductionHint {
    return Intl.message(
      'A short intro to tell people who you are',
      name: 'profileEditIntroductionHint',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get profileEditAbout {
    return Intl.message('About', name: 'profileEditAbout', desc: '', args: []);
  }

  /// `More details about you (max 500 characters)`
  String get profileEditAboutHint {
    return Intl.message(
      'More details about you (max 500 characters)',
      name: 'profileEditAboutHint',
      desc: '',
      args: [],
    );
  }

  /// `First name is required`
  String get profileEditFirstNameRequired {
    return Intl.message(
      'First name is required',
      name: 'profileEditFirstNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `PHOTO`
  String get profileEditSectionPhoto {
    return Intl.message(
      'PHOTO',
      name: 'profileEditSectionPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Profile Photo URL`
  String get profileEditPhotoUrl {
    return Intl.message(
      'Profile Photo URL',
      name: 'profileEditPhotoUrl',
      desc: '',
      args: [],
    );
  }

  /// `Enter a public image URL`
  String get profileEditPhotoUrlHint {
    return Intl.message(
      'Enter a public image URL',
      name: 'profileEditPhotoUrlHint',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get navAgenda {
    return Intl.message('Schedule', name: 'navAgenda', desc: '', args: []);
  }

  /// `Schedule`
  String get agendaTitle {
    return Intl.message('Schedule', name: 'agendaTitle', desc: '', args: []);
  }

  /// `Appointments`
  String get agendaTabAppointments {
    return Intl.message(
      'Appointments',
      name: 'agendaTabAppointments',
      desc: '',
      args: [],
    );
  }

  /// `My Availability`
  String get agendaTabAvailability {
    return Intl.message(
      'My Availability',
      name: 'agendaTabAvailability',
      desc: '',
      args: [],
    );
  }

  /// `UPCOMING`
  String get agendaUpcoming {
    return Intl.message('UPCOMING', name: 'agendaUpcoming', desc: '', args: []);
  }

  /// `PAST`
  String get agendaPast {
    return Intl.message('PAST', name: 'agendaPast', desc: '', args: []);
  }

  /// `No appointments yet`
  String get agendaEmptyTitle {
    return Intl.message(
      'No appointments yet',
      name: 'agendaEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Book a slot with someone from your support network.`
  String get agendaEmptyBody {
    return Intl.message(
      'Book a slot with someone from your support network.',
      name: 'agendaEmptyBody',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get agendaBookButton {
    return Intl.message(
      'Book Appointment',
      name: 'agendaBookButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel appointment?`
  String get agendaCancelTitle {
    return Intl.message(
      'Cancel appointment?',
      name: 'agendaCancelTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will free up the time slot for others.`
  String get agendaCancelBody {
    return Intl.message(
      'This will free up the time slot for others.',
      name: 'agendaCancelBody',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Appointment`
  String get agendaCancelConfirm {
    return Intl.message(
      'Cancel Appointment',
      name: 'agendaCancelConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Appointment cancelled`
  String get agendaCancelledSuccess {
    return Intl.message(
      'Appointment cancelled',
      name: 'agendaCancelledSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No available slots in the next 30 days`
  String get agendaNoSlots {
    return Intl.message(
      'No available slots in the next 30 days',
      name: 'agendaNoSlots',
      desc: '',
      args: [],
    );
  }

  /// `Appointment booked!`
  String get agendaBookedSuccess {
    return Intl.message(
      'Appointment booked!',
      name: 'agendaBookedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not book this slot. Please try again.`
  String get agendaBookError {
    return Intl.message(
      'Could not book this slot. Please try again.',
      name: 'agendaBookError',
      desc: '',
      args: [],
    );
  }

  /// `Add Availability`
  String get agendaAddAvailability {
    return Intl.message(
      'Add Availability',
      name: 'agendaAddAvailability',
      desc: '',
      args: [],
    );
  }

  /// `No availability set`
  String get agendaEmptyAvailability {
    return Intl.message(
      'No availability set',
      name: 'agendaEmptyAvailability',
      desc: '',
      args: [],
    );
  }

  /// `Add time windows for your network to book.`
  String get agendaEmptyAvailabilityBody {
    return Intl.message(
      'Add time windows for your network to book.',
      name: 'agendaEmptyAvailabilityBody',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get agendaSlotBooked {
    return Intl.message('Booked', name: 'agendaSlotBooked', desc: '', args: []);
  }

  /// `Available`
  String get agendaSlotAvailable {
    return Intl.message(
      'Available',
      name: 'agendaSlotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Remove availability?`
  String get agendaSlotDeleteTitle {
    return Intl.message(
      'Remove availability?',
      name: 'agendaSlotDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `This time window will be removed.`
  String get agendaSlotDeleteBody {
    return Intl.message(
      'This time window will be removed.',
      name: 'agendaSlotDeleteBody',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get agendaSlotDeleteConfirm {
    return Intl.message(
      'Remove',
      name: 'agendaSlotDeleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Remove recurring availability?`
  String get agendaSlotDeleteSeriesTitle {
    return Intl.message(
      'Remove recurring availability?',
      name: 'agendaSlotDeleteSeriesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Only this one`
  String get agendaSlotDeleteThisOnly {
    return Intl.message(
      'Only this one',
      name: 'agendaSlotDeleteThisOnly',
      desc: '',
      args: [],
    );
  }

  /// `All future occurrences`
  String get agendaSlotDeleteAllSeries {
    return Intl.message(
      'All future occurrences',
      name: 'agendaSlotDeleteAllSeries',
      desc: '',
      args: [],
    );
  }

  /// `Availability removed`
  String get agendaSlotDeletedSuccess {
    return Intl.message(
      'Availability removed',
      name: 'agendaSlotDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get agendaAddSlotStartTime {
    return Intl.message(
      'Start Time',
      name: 'agendaAddSlotStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get agendaAddSlotDuration {
    return Intl.message(
      'Duration',
      name: 'agendaAddSlotDuration',
      desc: '',
      args: [],
    );
  }

  /// `Repeat weekly`
  String get agendaAddSlotRecurring {
    return Intl.message(
      'Repeat weekly',
      name: 'agendaAddSlotRecurring',
      desc: '',
      args: [],
    );
  }

  /// `Creates availability for the next 8 weeks`
  String get agendaAddSlotRecurringHint {
    return Intl.message(
      'Creates availability for the next 8 weeks',
      name: 'agendaAddSlotRecurringHint',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get agendaAddSlotButton {
    return Intl.message('Add', name: 'agendaAddSlotButton', desc: '', args: []);
  }

  /// `Availability added!`
  String get agendaAddSlotSuccess {
    return Intl.message(
      'Availability added!',
      name: 'agendaAddSlotSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not add availability. Please try again.`
  String get agendaAddSlotError {
    return Intl.message(
      'Could not add availability. Please try again.',
      name: 'agendaAddSlotError',
      desc: '',
      args: [],
    );
  }

  /// `Export Calendar`
  String get agendaExportCalendar {
    return Intl.message(
      'Export Calendar',
      name: 'agendaExportCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Calendar exported!`
  String get agendaExportSuccess {
    return Intl.message(
      'Calendar exported!',
      name: 'agendaExportSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Could not export calendar. Please try again.`
  String get agendaExportError {
    return Intl.message(
      'Could not export calendar. Please try again.',
      name: 'agendaExportError',
      desc: '',
      args: [],
    );
  }

  /// `No upcoming appointments`
  String get agendaUpcomingNoAppointments {
    return Intl.message(
      'No upcoming appointments',
      name: 'agendaUpcomingNoAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Book a slot from your network to get started.`
  String get agendaNoAppointmentsBody {
    return Intl.message(
      'Book a slot from your network to get started.',
      name: 'agendaNoAppointmentsBody',
      desc: '',
      args: [],
    );
  }

  /// `Urgent`
  String get agendaUrgentLabel {
    return Intl.message(
      'Urgent',
      name: 'agendaUrgentLabel',
      desc: '',
      args: [],
    );
  }

  /// `You may need support`
  String get agendaHighRiskTitle {
    return Intl.message(
      'You may need support',
      name: 'agendaHighRiskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your care team has flagged you as high risk. Please reach out.`
  String get agendaHighRiskBody {
    return Intl.message(
      'Your care team has flagged you as high risk. Please reach out.',
      name: 'agendaHighRiskBody',
      desc: '',
      args: [],
    );
  }

  /// `Talk to therapist`
  String get agendaTalkToTherapist {
    return Intl.message(
      'Talk to therapist',
      name: 'agendaTalkToTherapist',
      desc: '',
      args: [],
    );
  }

  /// `Book urgent slot`
  String get agendaBookUrgentSlot {
    return Intl.message(
      'Book urgent slot',
      name: 'agendaBookUrgentSlot',
      desc: '',
      args: [],
    );
  }

  /// `No urgent slots available right now`
  String get agendaNoUrgentSlots {
    return Intl.message(
      'No urgent slots available right now',
      name: 'agendaNoUrgentSlots',
      desc: '',
      args: [],
    );
  }

  /// `Urgent appointment`
  String get agendaUrgentAppointment {
    return Intl.message(
      'Urgent appointment',
      name: 'agendaUrgentAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get networkBookAppointment {
    return Intl.message(
      'Book Appointment',
      name: 'networkBookAppointment',
      desc: '',
      args: [],
    );
  }

  /// `View available time slots`
  String get networkBookAppointmentSubtitle {
    return Intl.message(
      'View available time slots',
      name: 'networkBookAppointmentSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Privacy settings`
  String get networkPrivacySettings {
    return Intl.message(
      'Privacy settings',
      name: 'networkPrivacySettings',
      desc: '',
      args: [],
    );
  }

  /// `Control what this person can see`
  String get networkPrivacySettingsSubtitle {
    return Intl.message(
      'Control what this person can see',
      name: 'networkPrivacySettingsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `My Health Data`
  String get healthOverviewTitle {
    return Intl.message(
      'My Health Data',
      name: 'healthOverviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `MOOD HISTORY`
  String get healthMoodSectionTitle {
    return Intl.message(
      'MOOD HISTORY',
      name: 'healthMoodSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `INSIGHTS`
  String get healthInsightsSectionTitle {
    return Intl.message(
      'INSIGHTS',
      name: 'healthInsightsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete all mood data`
  String get healthDeleteAllMoodButton {
    return Intl.message(
      'Delete all mood data',
      name: 'healthDeleteAllMoodButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete all mood data?`
  String get healthDeleteAllMoodTitle {
    return Intl.message(
      'Delete all mood data?',
      name: 'healthDeleteAllMoodTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will permanently remove all your mood check-in entries. This action cannot be undone.`
  String get healthDeleteAllMoodBody {
    return Intl.message(
      'This will permanently remove all your mood check-in entries. This action cannot be undone.',
      name: 'healthDeleteAllMoodBody',
      desc: '',
      args: [],
    );
  }

  /// `Delete All`
  String get healthDeleteAllMoodConfirm {
    return Intl.message(
      'Delete All',
      name: 'healthDeleteAllMoodConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete all health data`
  String get healthDeleteStressButton {
    return Intl.message(
      'Delete all health data',
      name: 'healthDeleteStressButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete all health data?`
  String get healthDeleteStressTitle {
    return Intl.message(
      'Delete all health data?',
      name: 'healthDeleteStressTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will permanently remove all your stress scores and health samples. This action cannot be undone.`
  String get healthDeleteStressBody {
    return Intl.message(
      'This will permanently remove all your stress scores and health samples. This action cannot be undone.',
      name: 'healthDeleteStressBody',
      desc: '',
      args: [],
    );
  }

  /// `Delete All`
  String get healthDeleteStressConfirm {
    return Intl.message(
      'Delete All',
      name: 'healthDeleteStressConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete entry?`
  String get healthEntryDeleteTitle {
    return Intl.message(
      'Delete entry?',
      name: 'healthEntryDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get healthEntryDeleteConfirm {
    return Intl.message(
      'Delete',
      name: 'healthEntryDeleteConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Mood entry deleted`
  String get healthMoodDeletedSuccess {
    return Intl.message(
      'Mood entry deleted',
      name: 'healthMoodDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `All mood data deleted`
  String get healthMoodAllDeletedSuccess {
    return Intl.message(
      'All mood data deleted',
      name: 'healthMoodAllDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `All health data deleted`
  String get healthStressDeletedSuccess {
    return Intl.message(
      'All health data deleted',
      name: 'healthStressDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get healthDeleteError {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'healthDeleteError',
      desc: '',
      args: [],
    );
  }

  /// `No mood entries this week`
  String get healthNoMoodEntries {
    return Intl.message(
      'No mood entries this week',
      name: 'healthNoMoodEntries',
      desc: '',
      args: [],
    );
  }

  /// `No insights yet`
  String get healthNoInsights {
    return Intl.message(
      'No insights yet',
      name: 'healthNoInsights',
      desc: '',
      args: [],
    );
  }

  /// `Complete a check-in with your smartwatch data to see stress insights here.`
  String get healthNoInsightsBody {
    return Intl.message(
      'Complete a check-in with your smartwatch data to see stress insights here.',
      name: 'healthNoInsightsBody',
      desc: '',
      args: [],
    );
  }

  /// `Stress score: {score}`
  String healthStressScoreLabel(String score) {
    return Intl.message(
      'Stress score: $score',
      name: 'healthStressScoreLabel',
      desc: '',
      args: [score],
    );
  }

  /// `Computed {date}`
  String healthStressComputedAt(String date) {
    return Intl.message(
      'Computed $date',
      name: 'healthStressComputedAt',
      desc: '',
      args: [date],
    );
  }

  /// `Low`
  String get healthCategoryLow {
    return Intl.message('Low', name: 'healthCategoryLow', desc: '', args: []);
  }

  /// `Moderate`
  String get healthCategoryModerate {
    return Intl.message(
      'Moderate',
      name: 'healthCategoryModerate',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get healthCategoryHigh {
    return Intl.message('High', name: 'healthCategoryHigh', desc: '', args: []);
  }

  /// `Very High`
  String get healthCategoryVeryHigh {
    return Intl.message(
      'Very High',
      name: 'healthCategoryVeryHigh',
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
