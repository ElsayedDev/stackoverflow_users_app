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
    final name =
        (locale.countryCode?.isEmpty ?? false)
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

  /// `Stack Overflow Users`
  String get appTitle {
    return Intl.message(
      'Stack Overflow Users',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Bookmarked`
  String get bookmarked {
    return Intl.message('Bookmarked', name: 'bookmarked', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Navigation error`
  String get navigationError {
    return Intl.message(
      'Navigation error',
      name: 'navigationError',
      desc: '',
      args: [],
    );
  }

  /// `Loading user…`
  String get loadingUser {
    return Intl.message(
      'Loading user…',
      name: 'loadingUser',
      desc: '',
      args: [],
    );
  }

  /// `User Reputation`
  String get userReputation {
    return Intl.message(
      'User Reputation',
      name: 'userReputation',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load reputation history.`
  String get failedToLoadReputation {
    return Intl.message(
      'Failed to load reputation history.',
      name: 'failedToLoadReputation',
      desc: '',
      args: [],
    );
  }

  /// `No reputation events yet.`
  String get noReputationEvents {
    return Intl.message(
      'No reputation events yet.',
      name: 'noReputationEvents',
      desc: '',
      args: [],
    );
  }

  /// `this user`
  String get thisUser {
    return Intl.message('this user', name: 'thisUser', desc: '', args: []);
  }

  /// `Check back later to see how {name} earns reputation.`
  String checkBackLater(String name) {
    return Intl.message(
      'Check back later to see how $name earns reputation.',
      name: 'checkBackLater',
      desc:
          'Shown in empty state, {name} is the user\'s display name or a fallback.',
      args: [name],
    );
  }

  /// `Unable to open the Stack Overflow post.`
  String get unableToOpenPost {
    return Intl.message(
      'Unable to open the Stack Overflow post.',
      name: 'unableToOpenPost',
      desc: '',
      args: [],
    );
  }

  /// `Add bookmark`
  String get addBookmark {
    return Intl.message(
      'Add bookmark',
      name: 'addBookmark',
      desc: '',
      args: [],
    );
  }

  /// `Remove bookmark`
  String get removeBookmark {
    return Intl.message(
      'Remove bookmark',
      name: 'removeBookmark',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load users.`
  String get failedToLoadUsers {
    return Intl.message(
      'Failed to load users.',
      name: 'failedToLoadUsers',
      desc: '',
      args: [],
    );
  }

  /// `No users found.`
  String get noUsersFound {
    return Intl.message(
      'No users found.',
      name: 'noUsersFound',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
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
