// Minimal generated-like localizations to enable S.current usage in-app and tests.
// For production, prefer running `flutter gen-l10n` to generate this file.

import 'dart:async';
import 'package:flutter/widgets.dart';

class S {
  S([String? _]);
  static S? _current;
  static S get current => _current ??= S();

  static const LocalizationsDelegate<S> delegate = _SDelegate();
  static const List<Locale> supportedLocales = [Locale('en')];

  static Future<S> load(Locale locale) async {
    _current = S(locale.languageCode);
    return current;
  }

  static S of(BuildContext context) =>
      Localizations.of<S>(context, S) ?? current;

  // Strings from intl_en.arb
  String get appTitle => 'Stack Overflow Users';
  String get all => 'All';
  String get bookmarked => 'Bookmarked';
  String get retry => 'Retry';
  String get navigationError => 'Navigation error';
  String get loadingUser => 'Loading user…';
  String get userReputation => 'User Reputation';
  String get failedToLoadReputation => 'Failed to load reputation history.';
  String get noReputationEvents => 'No reputation events yet.';
  String get thisUser => 'this user';
  String checkBackLater(String name) =>
      'Check back later to see how $name earns reputation.';
  String get unableToOpenPost => 'Unable to open the Stack Overflow post.';
  String get addBookmark => 'Add bookmark';
  String get removeBookmark => 'Remove bookmark';
  String get noUsersFound => 'No users found.';
  String get failedToLoadUsers => 'Failed to load users.';
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<S> load(Locale locale) => S.load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<S> old) => false;
}
