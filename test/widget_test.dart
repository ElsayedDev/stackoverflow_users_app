// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/main.dart';

void main() {
  late Directory hiveDir;

  setUpAll(() async {
    hiveDir = await Directory.systemTemp.createTemp();
    Hive.init(hiveDir.path);
  });

  tearDownAll(() async {
    await Hive.close();
    await Hive.deleteFromDisk();
    if (hiveDir.existsSync()) {
      await hiveDir.delete(recursive: true);
    }
  });

  tearDown(() async {
    await Hive.close();
    await Hive.deleteFromDisk();
  });

  setUp(() async {
    await initServiceLocator(usersRepository: MockUsersRepository());
  });

  testWidgets('renders paginated users list', (tester) async {
    await tester.pumpWidget(const MyApp());

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
