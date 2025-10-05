import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:patrol/patrol.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import '../test/features/users/data/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/bookmarks/bookmarks_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/bookmarked_users_tab.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/users_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  late Directory hiveDir;

  setUpAll(() async {
    hiveDir = await Directory.systemTemp.createTemp('patrol_bm_tab');
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

  patrolTest('BookmarkedUsersTab shows empty then updates after bookmarking',
      ($) async {
    // Build a simple two-tab scaffold to allow toggling through UsersCubit
    await $.pumpWidgetAndSettle(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<UsersCubit>(create: (_) => sl<UsersCubit>()),
              BlocProvider<BookmarksCubit>(create: (_) => sl<BookmarksCubit>()),
            ],
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                      tabs: [Tab(text: 'All'), Tab(text: 'Bookmarked')]),
                ),
                body: TabBarView(
                  children: [
                    UsersTab(onUserTap: (_) {}),
                    BookmarkedUsersTab(onUserTap: (_) {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await $.pump(const Duration(milliseconds: 400));

    // Switch to Bookmarked: should be empty
    await $(find.text('Bookmarked')).tap();
    await $.pumpAndSettle();
    expect($(find.textContaining('No users found.')), findsOneWidget);

    // Back to All and bookmark the first one
    await $(find.text('All')).tap();
    await $.pumpAndSettle();
    expect($(find.text('User 001')), findsOneWidget);
    await $(find.byIcon(Icons.bookmark_border).first).tap();
    await $.pumpAndSettle();

    // Go to Bookmarked -> should contain the user now
    await $(find.text('Bookmarked')).tap();
    await $.pumpAndSettle();
    expect($(find.text('User 001')), findsOneWidget);
  });
}
