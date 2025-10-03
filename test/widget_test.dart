// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:stackoverflow_users_app/main.dart';

void main() {
  testWidgets('renders paginated users list', (tester) async {
    await tester.pumpWidget(MyApp());

    // Allow the initial load trigger to schedule.
    await tester.pump();
    // Wait for the mock repository delay to resolve.
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Stack Overflow Users'), findsOneWidget);
    expect(find.text('User 001'), findsOneWidget);
    expect(find.text('Bookmarked'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);

    await tester.tap(find.text('Bookmarked'));
    await tester.pumpAndSettle();

    expect(find.text("You haven't bookmarked any users yet."), findsOneWidget);
    expect(
      find.text('Use the All segment to show every user again.'),
      findsOneWidget,
    );

    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    expect(find.text('User 001'), findsOneWidget);
  });
}
