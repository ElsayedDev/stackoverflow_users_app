import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stackoverflow_users_app/core/network/dio_client.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_local_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/users_repository_impl.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator({UsersRepository? usersRepository}) async {
  await sl.reset();

  final localDataSource = await HiveUsersLocalDataSource.create();

  sl
    ..registerLazySingleton<Dio>(DioClient.create)
    ..registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl(sl(), pageSize: 20),
    )
    ..registerSingleton<UsersLocalDataSource>(localDataSource)
    ..registerLazySingleton<UsersRepository>(
      () =>
          usersRepository ??
          UsersRepositoryImpl(
            remote: sl(),
            local: sl(),
          ),
    )
    ..registerFactory<UsersCubit>(
      () => UsersCubit(sl()),
    )
    ..registerFactoryParam<ReputationCubit, int, void>(
      (userId, _) => ReputationCubit(sl(), userId: userId),
    );
}
