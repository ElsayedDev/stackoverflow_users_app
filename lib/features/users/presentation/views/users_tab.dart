import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/widgets/loading_center.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/empty_state_view.dart';
import 'package:stackoverflow_users_app/generated/l10n.dart';

import 'package:stackoverflow_users_app/features/users/presentation/widgets/users_tab_success_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/bookmark_feedback.dart';

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
    // for AutomaticKeepAliveClientMixin
    super.build(context);

    // Normal UI building below
    return BlocConsumer<UsersCubit, UsersState>(
      listenWhen: _listenWhen,
      listener: _handleViewListener,
      builder: (context, state) {
        final users = state.users;

        // Show initial loading indicator
        if (state.showInitialLoader) {
          return const LoadingCenter();
        }

        // Handle initial error state
        if (state.showInitialError) {
          return EmptyStateView(
            message: state.error ?? S.current.failedToLoadUsers,
            onRetry: _handleRetry,
            onRefresh: _handleRefresh,
          );
        }

        // Show empty state if there are no users
        if (users.isEmpty && !state.isLoading) {
          return EmptyStateView(
            message: S.current.noUsersFound,
            onRefresh: _handleRefresh,
          );
        }

        // If we reach here, we have users to show
        return UsersTabSuccessView(
          controller: _scrollController,
          items: users,
          isLoadingMore: state.isLoadingMore,
          onUserTap: widget.onUserTap,
          onToggleBookmark: _handleToggleBookmark,
          onRefresh: _handleRefresh,
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

  void _handleToggleBookmark(int id, bool isBookmarked) {
    final cubit = context.read<UsersCubit>();

    if (!isBookmarked) {
      cubit.onToggleBookmark(id);
      BookmarkFeedback.showBookmarkAddedSnack(context);
      return;
    }

    // for remove bookmark
    BookmarkFeedback.confirmUnbookmark(context).then(
      (confirmed) {
        if (confirmed != true) return;

        cubit.onToggleBookmark(id);

        if (!mounted) return;
        BookmarkFeedback.showBookmarkRemovedSnack(context);
      },
    );
  }

  void _handleRetry() {
    context.read<UsersCubit>().onLoadInit(force: true);
  }
}
