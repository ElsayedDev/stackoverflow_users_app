import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/utils/app_launcher.dart';
import 'package:stackoverflow_users_app/core/widgets/loading_center.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/empty_state_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/reputation_list.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_profile_header.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_reputation_app_bar.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_reputation_error_state_view.dart';
import 'package:stackoverflow_users_app/generated/l10n.dart';

/// View = subscribes to Cubit state and builds UI.
/// All UI helpers are extracted to widgets for clarity & reuse.
class UserReputationView extends StatefulWidget {
  const UserReputationView({super.key});

  @override
  State<UserReputationView> createState() => _UserReputationViewState();
}

class _UserReputationViewState extends State<UserReputationView> {
  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController()..addListener(_onScroll);
    // load first page after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReputationCubit>().onLoadInit();
    });
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: UserReputationAppBar(),
        body: BlocConsumer<ReputationCubit, ReputationState>(
          listenWhen: _handleWhenUiEffect,
          listener: _handleUIEffect,
          builder: (context, state) {
            // Initial states
            if (state.showInitialLoader) {
              return const LoadingCenter();
            }

            if (state.showInitialError) {
              return UserReputationErrorStateView(
                message: state.error ?? S.current.failedToLoadReputation,
                onRetry: _handleRetry,
              );
            }

            if (state.showEmptyState) {
              return EmptyStateView(
                message: S.current.noReputationEvents,
                subMessage: S.current
                    .checkBackLater(state.user?.name ?? S.current.thisUser),
                onRefresh: _handleRefresh,
              );
            }

            return RefreshIndicator(
              onRefresh: _handleRefresh,
              child: CustomScrollView(
                controller: _scroll,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: UserProfileHeader(
                      user: state.user,
                      isLoading: state.isUserLoading,
                      error: state.userError,
                    ),
                  ),
                  SliverPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    sliver: ReputationListSliver(
                      items: state.items,
                      isLoadingMore: state.isLoadingMore,
                      onPostOpened: (id) => _openPost(id),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  // ----------------------------- Helpers -----------------------------

  void _onScroll() {
    if (!_scroll.hasClients) return;
    if (_scroll.position.extentAfter < 200) {
      context.read<ReputationCubit>().onLoadMore();
    }
  }

  bool _handleWhenUiEffect(prev, curr) =>
      prev.error != curr.error && curr.error != null && !curr.showInitialError;

  void _handleUIEffect(context, state) {
    final msg = state.error;
    if (msg == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _openPost(int postId) async {
    final opened = await AppLauncher.openPost(postId);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(S.current.unableToOpenPost)),
        );
    }
  }

  Future<void> _handleRefresh() async =>
      await context.read<ReputationCubit>().onRefresh();

  void _handleRetry() async =>
      context.read<ReputationCubit>().onLoadInit(force: true);
}
