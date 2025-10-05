import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import '../data/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_reputation.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_user_by_id.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/user_reputation_view.dart';

void main() {
  group('UserReputationPage', () {
    testWidgets('renders reputation items after loading', (tester) async {
      final repository = MockUsersRepository(pageSize: 10);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (_, __) => BlocProvider<ReputationCubit>(
            create: (_) => ReputationCubit(
              GetReputation(repository),
              GetUserById(repository),
            )..onInit(1),
            child: MaterialApp(
              home: UserReputationView(),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('User 001'), findsAtLeastNWidgets(1));
      expect(find.text('Post #1001'), findsOneWidget);
    });
  });
}
