import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:hive/hive.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/my_app.dart';

void main() {
  late Directory hiveDir;

  setUpAll(() async {
    hiveDir = await Directory.systemTemp.createTemp('patrol_home');
    Hive.init(hiveDir.path);
    await initServiceLocator(usersRepository: MockUsersRepository());
  });

  tearDownAll(() async {
    await Hive.close();
    await Hive.deleteFromDisk();
    if (hiveDir.existsSync()) {
      await hiveDir.delete(recursive: true);
    }
  });

  patrolTest('HomeView shows users and toggles tabs', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());

    // allow mocked initial fetch
    await $.pump(const Duration(milliseconds: 400));

    expect($(find.text('Stack Overflow Users')), findsOneWidget);
    expect($(find.text('All')), findsOneWidget);
    expect($(find.text('Bookmarked')), findsOneWidget);

    // All tab should list first user
    expect($(find.text('User 001')), findsOneWidget);

    // Bookmarked is empty by default
    await $(find.text('Bookmarked')).tap();
    await $.pumpAndSettle();
    expect($(find.textContaining('No users found.')), findsOneWidget);

    // Back to All
    await $(find.text('All')).tap();
    await $.pumpAndSettle();
    expect($(find.text('User 001')), findsOneWidget);
  });
}
