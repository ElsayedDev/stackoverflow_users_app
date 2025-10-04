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
    hiveDir = await Directory.systemTemp.createTemp('patrol_rep_view');
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

  patrolTest('UserReputationView opens and shows reputation feed', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());

    // Allow initial mocked fetch and make sure we're on the All tab
    await $.pump(const Duration(milliseconds: 400));
    if ($(find.text('All')).evaluate().isNotEmpty) {
      await $(find.text('All')).tap();
      await $.pumpAndSettle();
    }

    // Open first user details by tapping on their name
    // Be a bit more patient on slower emulators
    await $.pump(const Duration(milliseconds: 300));
    expect($(find.text('User 001')), findsWidgets);
    await $(find.text('User 001').first).tap();
    await $.pumpAndSettle();

    // Allow reputation initial fetch
    await $.pump(const Duration(milliseconds: 300));

    // Expect profile header pieces and one reputation item
    expect($(find.text('User 001')), findsWidgets);
    expect($(find.textContaining('Post #1001')), findsOneWidget);
  });
}
