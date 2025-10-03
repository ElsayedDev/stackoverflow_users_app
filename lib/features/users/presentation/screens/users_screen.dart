import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/di/service_locator.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/users_state.dart';
import 'package:stackoverflow_users_app/features/users/presentation/screens/user_reputation_screen.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_tile.dart';
import 'package:stackoverflow_users_app/gen/assets.gen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersCubit>().loadInitial();
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    const threshold = 200.0;
    if (position.maxScrollExtent - position.pixels <= threshold) {
      context.read<UsersCubit>().loadMore();
    }
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
    final showBookmarksOnly = context.select(
      (UsersCubit cubit) => cubit.state.showBookmarksOnly,
    );
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
          child: Assets.icons.icStackoverflow.svg(
            width: 24.r,
            height: 24.r,
          ),
        ),
        title: const Text('Stack Overflow Users'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<bool>(
                segments: const [
                  ButtonSegment<bool>(
                    value: false,
                    label: Text('All'),
                    icon: Icon(Icons.group_outlined),
                  ),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text('Bookmarked'),
                    icon: Icon(Icons.bookmark_rounded),
                  ),
                ],
                selected: <bool>{showBookmarksOnly},
                onSelectionChanged: (selection) {
                  final showOnly = selection.contains(true);
                  context.read<UsersCubit>().setBookmarksFilter(showOnly);
                },
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<UsersCubit, UsersState>(
        listenWhen: (previous, current) =>
            previous.error != current.error &&
            current.error != null &&
            !current.showInitialError,
        listener: (context, state) {
          final message = state.error;
          if (message == null) return;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            );
        },
        builder: (context, state) {
          final mediaQuery = MediaQuery.of(context);
          final width = mediaQuery.size.width;
          final isLandscape = mediaQuery.orientation == Orientation.landscape;
          final adaptiveColumns = (width / 360).floor().clamp(1, 4);
          final useGrid = isLandscape && adaptiveColumns > 1;

          if (state.showInitialLoader) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.showInitialError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.error ?? 'Failed to load users.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<UsersCubit>().loadInitial(force: true),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final displayedUsers = state.showBookmarksOnly
              ? state.users
                  .where((user) => state.bookmarks.contains(user.id))
                  .toList(growable: false)
              : state.users;

          if (displayedUsers.isEmpty && !state.isLoading) {
            final message = state.showBookmarksOnly
                ? 'You haven\'t bookmarked any users yet.'
                : 'No users available yet.';
            return RefreshIndicator(
              onRefresh: () => _handleRefresh(context),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  SizedBox(height: 120.h),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (state.showBookmarksOnly) ...[
                          SizedBox(height: 8.h),
                          Text(
                            'Use the All segment to show every user again.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => _handleRefresh(context),
            child: useGrid
                ? GridView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: adaptiveColumns,
                      mainAxisExtent: 100.h,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount:
                        displayedUsers.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= displayedUsers.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final user = displayedUsers[index];
                      final badges = user.badgeCounts;

                      return UserTile(
                        avatarUrl: user.avatar,
                        name: user.name,
                        reputation: user.reputation,
                        badges: (badges.gold, badges.silver, badges.bronze),
                        bookmarked: state.bookmarks.contains(user.id),
                        onTap: () =>
                            _handleOpenDetails(context, user.id, user.name),
                        onToggleBookmark: () =>
                            _handleToggleBookmark(context, user.id),
                      );
                    },
                  )
                : ListView.separated(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        displayedUsers.length + (state.isLoadingMore ? 1 : 0),
                    separatorBuilder: (context, index) => Divider(
                      height: 1.h,
                      color: Theme.of(context).dividerColor,
                    ),
                    itemBuilder: (context, index) {
                      if (index >= displayedUsers.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }

                      final user = displayedUsers[index];
                      final badges = user.badgeCounts;

                      return UserTile(
                        avatarUrl: user.avatar,
                        name: user.name,
                        reputation: user.reputation,
                        badges: (badges.gold, badges.silver, badges.bronze),
                        bookmarked: state.bookmarks.contains(user.id),
                        onTap: () =>
                            _handleOpenDetails(context, user.id, user.name),
                        onToggleBookmark: () =>
                            _handleToggleBookmark(context, user.id),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  void _handleToggleBookmark(BuildContext context, int id) {
    context.read<UsersCubit>().toggleBookmark(id);
  }

  void _handleOpenDetails(BuildContext context, int id, String name) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (routeContext) => BlocProvider(
          create: (_) => sl<ReputationCubit>(param1: id),
          child: UserReputationScreen(
            userId: id,
            userName: name,
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh(BuildContext context) async {
    await context.read<UsersCubit>().refresh();
  }
}
