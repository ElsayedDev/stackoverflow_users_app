import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/routes/app_router.dart';
import 'package:stackoverflow_users_app/core/routes/app_routes.dart';
import 'package:stackoverflow_users_app/core/theme/soft_theme.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'StackOverflow Users',
          // TODO(next-enhance): Add dark theme support aligned with SOF design.
          theme: SOFTheme.light,
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
        // TODO(next-enhance): replace with a proper Splash Screen
        child: const HomeScreen(),
      );
}
