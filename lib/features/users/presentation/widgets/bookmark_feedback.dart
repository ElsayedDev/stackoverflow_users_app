import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/generated/l10n.dart';

abstract class BookmarkFeedback {
  static Future<bool> confirmUnbookmark(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(S.current.confirmUnbookmarkTitle),
            content: Text(S.current.confirmUnbookmarkMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(S.current.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(S.current.remove),
              ),
            ],
          ),
        ) ??
        false;
  }

  static void showBookmarkAddedSnack(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(S.current.bookmarkAdded)));
  }

  static void showBookmarkRemovedSnack(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(S.current.bookmarkRemoved)));
  }
}
