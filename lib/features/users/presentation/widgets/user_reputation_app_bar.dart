import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';

class UserReputationAppBar extends AppBar {
  UserReputationAppBar({super.key})
      : super(
          // Keep app bar rebuilds minimal
          title:
              BlocSelector<ReputationCubit, ReputationState, (bool, String?)>(
            selector: (s) => (s.isUserLoading, s.user?.name),
            builder: (_, tuple) {
              final (loading, name) = tuple;
              return Text(
                  loading ? 'Loading user…' : (name ?? 'User Reputation'));
            },
          ),
        );
}
