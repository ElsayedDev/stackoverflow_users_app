import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/bookmarks/bookmarks_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/home/home_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';

class HomeProviders extends MultiBlocProvider {
  HomeProviders({super.key, required super.child})
      : super(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => sl<HomeCubit>(),
            ),
            BlocProvider<UsersCubit>(
              create: (context) => sl<UsersCubit>(),
            ),
            BlocProvider<BookmarksCubit>(
              create: (context) => sl<BookmarksCubit>(),
            ),
          ],
        );
}
