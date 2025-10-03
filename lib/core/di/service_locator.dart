import 'package:get_it/get_it.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/mock_users_repository.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl
    ..registerLazySingleton<UsersRepository>(
      () => MockUsersRepository(),
    )
    ..registerFactory<UsersCubit>(
      () => UsersCubit(sl()),
    )
    ..registerFactory<ReputationCubit>(
      () => ReputationCubit(sl()),
    );
}
