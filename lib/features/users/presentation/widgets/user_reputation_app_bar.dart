import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';
import 'package:stackoverflow_users_app/generated/l10n.dart';

class UserReputationAppBar extends AppBar {
  UserReputationAppBar({super.key})
      : super(
          title:
              BlocSelector<ReputationCubit, ReputationState, (bool, String?)>(
            selector: (s) => (s.isUserLoading, s.user?.name),
            builder: (_, tuple) {
              final (loading, name) = tuple;
              return Text(
                loading
                    ? S.current.loadingUser
                    : (name ?? S.current.userReputation),
              );
            },
          ),
        );
}
