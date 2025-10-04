import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Stack Overflow Users';

  @override
  String get all => 'All';

  @override
  String get bookmarked => 'Bookmarked';

  @override
  String get retry => 'Retry';

  @override
  String get navigationError => 'Navigation error';

  @override
  String get loadingUser => 'Loading user…';

  @override
  String get userReputation => 'User Reputation';

  @override
  String get failedToLoadReputation => 'Failed to load reputation history.';

  @override
  String get noReputationEvents => 'No reputation events yet.';

  @override
  String get thisUser => 'this user';

  @override
  String checkBackLater(String name) {
    return 'Check back later to see how $name earns reputation.';
  }

  @override
  String get unableToOpenPost => 'Unable to open the Stack Overflow post.';

  @override
  String get addBookmark => 'Add bookmark';

  @override
  String get removeBookmark => 'Remove bookmark';
}
