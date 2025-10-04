import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stackoverflow_users_app/core/network/dio_client.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_local_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/datasources/users_remote_data_source.dart';
import 'package:stackoverflow_users_app/features/users/data/repositories/users_repository_impl.dart';
import 'package:stackoverflow_users_app/features/users/domain/repositories/users_repo.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_reputation.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_user_by_id.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/get_users_by_ids.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/toggle_bookmark.dart';
import 'package:stackoverflow_users_app/features/users/domain/usecases/watch_bookmarks.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/bookmarks/bookmarks_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/home/home_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';

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
            sl(),
            sl(),
          ),
    )
    ..registerLazySingleton<GetUsersByIds>(
      () => GetUsersByIds(sl()),
    )
    ..registerLazySingleton<GetUsers>(
      () => GetUsers(sl()),
    )
    ..registerLazySingleton<GetUserById>(
      () => GetUserById(sl()),
    )
    ..registerLazySingleton<GetReputation>(
      () => GetReputation(sl()),
    )
    ..registerLazySingleton<ToggleBookmark>(
      () => ToggleBookmark(sl()),
    )
    ..registerLazySingleton<WatchBookmarks>(
      () => WatchBookmarks(sl()),
    )
    ..registerFactory<HomeCubit>(
      () => HomeCubit(),
    )
    ..registerFactory<UsersCubit>(
      () => UsersCubit(
        sl(),
        sl(),
        sl(),
      ),
    )
    ..registerFactory<BookmarksCubit>(
      () => BookmarksCubit(
        getUsersByIds: sl(),
        toggleBookmark: sl(),
        watchBookmarks: sl(),
      ),
    )
    ..registerFactory<ReputationCubit>(
      () => ReputationCubit(sl(), sl()),
    );
}
