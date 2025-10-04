import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/user_reputation_screen_args.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/user_reputation_view.dart';

/// Screen = DI + route-level wiring only.
/// No UI logic here; that lives in the View.
class UserReputationScreen extends StatelessWidget {
  const UserReputationScreen({super.key, required this.args});

  final UserReputationScreenArgs args;

  @override
  Widget build(BuildContext context) => BlocProvider<ReputationCubit>(
        create: (_) => sl<ReputationCubit>()..onInit(args.userId),
        child: const UserReputationView(),
      );
}
