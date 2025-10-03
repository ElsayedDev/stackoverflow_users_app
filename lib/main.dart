import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/theme/soft_theme.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/users_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, UsersRepository? repository})
      : _repository = repository ?? MockUsersRepository();

  final UsersRepository _repository;

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<UsersRepository>.value(value: _repository),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<UsersCubit>(
                  create: (context) => UsersCubit(_repository),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'StackOverflow Users',
                // TODO(next-enhance): Add dark theme support aligned with SOF design.
                theme: SOFTheme.light,
                home: child,
              ),
            ),
          );
        },
        child: const UsersScreen(),
      );
}
