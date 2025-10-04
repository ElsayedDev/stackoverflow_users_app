import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/routes/app_routes.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/home/home_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/home_filter_option.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/user_reputation_screen_args.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/bookmarked_users_tab.dart';
import 'package:stackoverflow_users_app/features/users/presentation/views/users_tab.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocSelector<HomeCubit, HomeState, HomeFilterOption>(
        selector: (state) => state.filterOption,
        builder: (context, filterOption) => Scaffold(
          appBar: HomeAppBar(
            selectedOption: filterOption,
            onFilterChanged: (option) =>
                _handleChangeFilterOption(context, option),
          ),
          body: IndexedStack(
            index: filterOption == HomeFilterOption.all ? 0 : 1,
            children: [
              UsersTab(
                onUserTap: (id) => _handleOpenDetails(context, id),
              ),
              BookmarkedUsersTab(
                onUserTap: (id) => _handleOpenDetails(context, id),
              ),
            ],
          ),
        ),
      );

  // ------------------------- Private Methods -------------------------
  void _handleChangeFilterOption(
    BuildContext context,
    HomeFilterOption option,
  ) =>
      context.read<HomeCubit>().onFilterOptionChanged(option);

  void _handleOpenDetails(BuildContext context, int id) =>
      Navigator.of(context).pushNamed(
        AppRoutes.reputation,
        arguments: UserReputationScreenArgs(
          userId: id,
        ),
      );
}
