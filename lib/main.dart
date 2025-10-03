import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/core/theme/soft_theme.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/users_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<UsersRepository>.value(
                value: sl<UsersRepository>(),
              ),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider<UsersCubit>(
                  create: (context) => sl<UsersCubit>(),
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
