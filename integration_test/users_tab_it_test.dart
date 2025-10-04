import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:patrol/patrol.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/users_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  late Directory hiveDir;

  setUpAll(() async {
    hiveDir = await Directory.systemTemp.createTemp('patrol_users_tab');
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

  patrolTest('UsersTab renders and can toggle bookmark', ($) async {
    await $.pumpWidgetAndSettle(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          home: BlocProvider<UsersCubit>(
            create: (_) => sl<UsersCubit>(),
            child: UsersTab(onUserTap: (_) {}),
          ),
        ),
      ),
    );

    // initial mock fetch
    await $.pump(const Duration(milliseconds: 400));

    expect($(find.text('User 001')), findsOneWidget);

    // Tap first tile's bookmark icon
    final bookmarkIcon = find.byIcon(Icons.bookmark_border).first;
    await $(bookmarkIcon).tap();
    await $.pumpAndSettle();

    // Icon switches to filled bookmark
    expect($(find.byIcon(Icons.bookmark)), findsWidgets);
  });
}
