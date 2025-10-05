import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/core/widgets/responsive_list_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/user_ui.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_tile.dart';

class UsersTabSuccessView extends StatelessWidget {
  final ScrollController controller;
  final List<UserUi> items;
  final bool isLoadingMore;
  final void Function(int id) onUserTap;
  final void Function(int id, bool isBookmarked) onToggleBookmark;
  final Future<void> Function() onRefresh;

  const UsersTabSuccessView({
    super.key,
    required this.controller,
    required this.items,
    required this.isLoadingMore,
    required this.onUserTap,
    required this.onToggleBookmark,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: onRefresh,
        child: ResponsiveListView(
          key: const PageStorageKey('users_tab_list'),
          controller: controller,
          items: items,
          isLoadingMore: isLoadingMore,
          showDividers: true,
          itemBuilder: (context, item) {
            final user = item.user;
            final badges = user.badgeCounts;

            return UserTile(
              avatarUrl: user.avatar,
              name: user.name,
              reputation: user.reputation,
              badges: (badges.gold, badges.silver, badges.bronze),
              bookmarked: item.isBookmarked,
              onTap: () => onUserTap(user.id),
              onToggleBookmark: () =>
                  onToggleBookmark(user.id, item.isBookmarked),
            );
          },
        ),
      );
}
