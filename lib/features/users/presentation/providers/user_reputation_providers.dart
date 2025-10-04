import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';

class UserReputationProviders extends MultiBlocProvider {
  UserReputationProviders(
      {super.key, required super.child, required int userId})
      : super(
          providers: [
            BlocProvider<ReputationCubit>(
              create: (context) => sl<ReputationCubit>()..onInit(userId),
            ),
          ],
        );
}
