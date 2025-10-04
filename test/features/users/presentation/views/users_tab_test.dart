import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/users_tab.dart';

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

  testWidgets('UsersTab loads and displays a list of users', (tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<UsersCubit>(
            create: (_) => sl<UsersCubit>(),
            child: UsersTab(onUserTap: (_) {}),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('No users found.'), findsNothing);
    expect(find.text('User 001'), findsOneWidget);
  });
}
