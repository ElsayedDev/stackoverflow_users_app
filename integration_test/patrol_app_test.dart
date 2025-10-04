import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:stackoverflow_users_app/my_app.dart';

void main() {
  patrolTest('navigates to Bookmarked tab and back to All', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());

    // Assert header
    expect($(find.text('Stack Overflow Users')), findsOneWidget);

    // Tap Bookmarked
    await $(find.text('Bookmarked')).tap();
    await $.pumpAndSettle();

    // Expect empty state text
    expect($(find.textContaining('No users found.')), findsOneWidget);

    // Back to All
    await $(find.text('All')).tap();
    await $.pumpAndSettle();

    // Expect at least one user
    expect($(find.textContaining('User')), findsWidgets);
  });
}
