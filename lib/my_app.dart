import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/l10n/l10n.dart';
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
          // Title will be overridden by S, keep a fallback
          title: 'StackOverflow Users',
          // TODO(next-enhance): Add dark theme support aligned with SOF design.
          theme: SOFTheme.light,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.supportedLocales,
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
        // TODO(next-enhance): replace with a proper Splash Screen
        child: const HomeScreen(),
      );
}
