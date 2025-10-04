import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/core/routes/app_routes.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/user_reputation_screen_args.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/home_screen.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/user_reputation_screen.dart';
import 'package:stackoverflow_users_app/generated/l10n.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.reputation:
        final args = settings.arguments;

        if (args is! UserReputationScreenArgs) {
          return _errorRoute('Missing reputation arguments');
        }

        return MaterialPageRoute<void>(
          builder: (_) => UserReputationScreen(args: args),
        );
      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) => MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(S.current.navigationError)),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        ),
      );
}
