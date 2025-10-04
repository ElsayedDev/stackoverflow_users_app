import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/presentation/providers/home_providers.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/home_view.dart';

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

  testWidgets('HomeView shows tabs and loads users, filters to Bookmarked',
      (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: HomeProviders(child: HomeView()),
        ),
      ),
    );

    // Allow init microtasks and mocked delays
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Stack Overflow Users'), findsOneWidget);
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Bookmarked'), findsOneWidget);

    // Users list should render at least first user
    expect(find.text('User 001'), findsOneWidget);

    // Switch to Bookmarked -> empty state by default
    await tester.tap(find.text('Bookmarked'));
    await tester.pumpAndSettle();
    expect(find.textContaining('No users found.'), findsOneWidget);

    // Switch back to All -> still shows users
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();
    expect(find.text('User 001'), findsOneWidget);
  });
}
