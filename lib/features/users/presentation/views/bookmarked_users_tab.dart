import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stackoverflow_users_app/core/widgets/loading_center.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/bookmarks/bookmarks_cubit.dart';
import 'package:stackoverflow_users_app/l10n/l10n.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/empty_state_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/bookmarked_users_tab_success_view.dart';

class BookmarkedUsersTab extends StatefulWidget {
  final void Function(int id) onUserTap;

  const BookmarkedUsersTab({
    super.key,
    required this.onUserTap,
  });

  @override
  State<BookmarkedUsersTab> createState() => _BookmarkedUsersTabState();
}

class _BookmarkedUsersTabState extends State<BookmarkedUsersTab>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookmarksCubit>().onLoadInit();
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
    return BlocConsumer<BookmarksCubit, BookmarksState>(
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

        // Show empty state if there are no bookmarked users
        if (users.isEmpty && !state.isLoading) {
          return EmptyStateView(
            message: S.current.noUsersFound,
            onRefresh: _handleRefresh,
          );
        }

        // If we reach here, we have users to show
        return BookmarkedUsersTabSuccessView(
          controller: _scrollController,
          users: users,
          isLoadingMore: state.isLoadingMore,
          onUserTap: widget.onUserTap,
          onRemoveBookmark: _handleRemoveBookmark,
          onRefresh: _handleRefresh,
        );
      },
    );
  }

  // ------------------------- Helper -------------------------

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final extentAfter = _scrollController.position.extentAfter;
    if (extentAfter < 200) {
      context.read<BookmarksCubit>().onLoadMore();
    }
  }

  bool _listenWhen(BookmarksState previous, BookmarksState current) =>
      previous.error != current.error &&
      current.error != null &&
      !current.showInitialError;

  void _handleViewListener(BuildContext context, BookmarksState state) {
    final message = state.error;
    if (message == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  Future<void> _handleRefresh() async =>
      await context.read<BookmarksCubit>().onRefresh();

  void _handleRemoveBookmark(int id) {
    context.read<BookmarksCubit>().onToggleBookmark(id);
  }

  void _handleRetry() {
    context.read<BookmarksCubit>().onLoadInit(force: true);
  }
}
