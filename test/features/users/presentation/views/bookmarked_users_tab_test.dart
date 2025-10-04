import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/bookmarks/bookmarks_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/bookmarked_users_tab.dart';

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

  testWidgets('BookmarkedUsersTab shows empty state when no bookmarks',
      (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<BookmarksCubit>(
            create: (_) => sl<BookmarksCubit>(),
            child: BookmarkedUsersTab(onUserTap: (_) {}),
          ),
        ),
      ),
    );

    // Initial pump + a frame for cubit to start and finish initial load
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 10));

    // No bookmarks initially -> empty state
    expect(find.textContaining('No users found.'), findsOneWidget);
  });
}
