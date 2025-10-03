import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_cubit.dart';
import 'package:stackoverflow_users_app/features/users/presentation/cubit/reputation_state.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/reputation_tile.dart';
import 'package:stackoverflow_users_app/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class UserReputationScreen extends StatefulWidget {
  const UserReputationScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  final int userId;
  final String userName;

  @override
  State<UserReputationScreen> createState() => _UserReputationScreenState();
}

class _UserReputationScreenState extends State<UserReputationScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReputationCubit>().loadInitial();
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    const threshold = 200.0;
    if (position.maxScrollExtent - position.pixels <= threshold) {
      context.read<ReputationCubit>().loadMore();
    }
  }

  Future<void> _openPost(int postId) async {
    final uri = Uri.parse('https://stackoverflow.com/questions/$postId');
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
              content: Text('Unable to open the Stack Overflow post.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.userName}\'s reputation'),
      ),
      body: BlocConsumer<ReputationCubit, ReputationState>(
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
                      state.error ?? 'Failed to load reputation history.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ReputationCubit>()
                          .loadInitial(force: true),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.showEmptyState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No reputation events yet.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Check back later to see how ${widget.userName} earns reputation.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: ColorName.sofMuted),
                    ),
                  ],
                ),
              ),
            );
          }

          final mediaQuery = MediaQuery.of(context);
          final width = mediaQuery.size.width;
          final isLandscape = mediaQuery.orientation == Orientation.landscape;
          final adaptiveColumns = (width / 420).floor().clamp(1, 4);
          final useGrid = isLandscape && adaptiveColumns > 1;

          return RefreshIndicator(
            onRefresh: () => context.read<ReputationCubit>().refresh(),
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
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 2.8.r,
                    ),
                    itemCount:
                        state.items.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.items.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final ReputationEntity item = state.items[index];
                      return ReputationTile(
                        item: item,
                        onOpenPost: () => _openPost(item.postId),
                      );
                    },
                  )
                : ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        state.items.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.items.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      }

                      final ReputationEntity item = state.items[index];
                      return ReputationTile(
                        item: item,
                        onOpenPost: () => _openPost(item.postId),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
