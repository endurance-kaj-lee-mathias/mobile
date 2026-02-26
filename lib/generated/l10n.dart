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

  /// `Welcome back. You are not alone.`
  String get homeWelcome {
    return Intl.message(
      'Welcome back. You are not alone.',
      name: 'homeWelcome',
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
