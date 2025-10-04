import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/features/users/presentation/providers/home_providers.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => HomeProviders(
        child: HomeView(),
      );
}
