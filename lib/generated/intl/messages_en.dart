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

  static String m0(name) =>
      "Check back later to see how ${name} earns reputation.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addBookmark": MessageLookupByLibrary.simpleMessage("Add bookmark"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Stack Overflow Users"),
    "bookmarked": MessageLookupByLibrary.simpleMessage("Bookmarked"),
    "checkBackLater": m0,
    "failedToLoadReputation": MessageLookupByLibrary.simpleMessage(
      "Failed to load reputation history.",
    ),
    "failedToLoadUsers": MessageLookupByLibrary.simpleMessage(
      "Failed to load users.",
    ),
    "loadingUser": MessageLookupByLibrary.simpleMessage("Loading user…"),
    "navigationError": MessageLookupByLibrary.simpleMessage("Navigation error"),
    "noReputationEvents": MessageLookupByLibrary.simpleMessage(
      "No reputation events yet.",
    ),
    "noUsersFound": MessageLookupByLibrary.simpleMessage("No users found."),
    "removeBookmark": MessageLookupByLibrary.simpleMessage("Remove bookmark"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "thisUser": MessageLookupByLibrary.simpleMessage("this user"),
    "unableToOpenPost": MessageLookupByLibrary.simpleMessage(
      "Unable to open the Stack Overflow post.",
    ),
    "userReputation": MessageLookupByLibrary.simpleMessage("User Reputation"),
  };
}
