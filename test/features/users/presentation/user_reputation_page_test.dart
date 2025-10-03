import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/user_reputation_screen.dart';

void main() {
  group('UserReputationPage', () {
    testWidgets('renders reputation items after loading', (tester) async {
      final repository = MockUsersRepository(pageSize: 10);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (_, __) => RepositoryProvider<UsersRepository>.value(
            value: repository,
            child: BlocProvider<ReputationCubit>(
              create: (_) => ReputationCubit(repository, userId: 1),
              child: const MaterialApp(
                home: UserReputationScreen(
                  userId: 1,
                  userName: 'User 001',
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text("User 001's reputation"), findsOneWidget);
      expect(find.text('Post #1001'), findsOneWidget);
    });
  });
}
