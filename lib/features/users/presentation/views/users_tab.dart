import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/widgets/loading_center.dart';
import 'package:stackoverflow_users_app/core/widgets/responsive_list_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/empty_state_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_tile.dart';

class UsersTab extends StatefulWidget {
  final void Function(int id) onUserTap;

  const UsersTab({
    super.key,
    required this.onUserTap,
  });

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersCubit>().onLoadInit();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<UsersCubit, UsersState>(
      listenWhen: _listenWhen,
      listener: _handleViewListener,
      builder: (context, state) {
        final users = state.users;

        if (state.showInitialLoader) {
          return const LoadingCenter();
        }

        if (state.showInitialError) {
          return EmptyStateView(
            message: state.error ?? 'Failed to load users.',
            onRetry: () => context.read<UsersCubit>().onLoadInit(force: true),
            onRefresh: _handleRefresh,
          );
        }

        if (users.isEmpty && !state.isLoading) {
          return EmptyStateView(
            message: 'No users found.',
            onRefresh: _handleRefresh,
          );
        }

        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ResponsiveListView(
            key: const PageStorageKey('users_tab_list'),
            controller: _scrollController,
            items: users,
            isLoadingMore: state.isLoadingMore,
            showDividers: true,
            itemBuilder: (context, item) {
              final user = item.user;
              final isBookmarked = item.isBookmarked;
              final badges = user.badgeCounts;

              return UserTile(
                avatarUrl: user.avatar,
                name: user.name,
                reputation: user.reputation,
                badges: (badges.gold, badges.silver, badges.bronze),
                bookmarked: isBookmarked,
                onTap: () => widget.onUserTap(user.id),
                onToggleBookmark: () => _handleToggleBookmark(user.id),
              );
            },
          ),
        );
      },
    );
  }

  // ------------------------- Private Methods -------------------------

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final extentAfter = _scrollController.position.extentAfter;
    if (extentAfter < 200) {
      context.read<UsersCubit>().onLoadMore();
    }
  }

  bool _listenWhen(UsersState previous, UsersState current) =>
      previous.error != current.error &&
      current.error != null &&
      !current.showInitialError;

  void _handleViewListener(BuildContext context, UsersState state) {
    final message = state.error;
    if (message == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  Future<void> _handleRefresh() async =>
      await context.read<UsersCubit>().onRefresh();

  void _handleToggleBookmark(int id) {
    context.read<UsersCubit>().onToggleBookmark(id);
  }
}
