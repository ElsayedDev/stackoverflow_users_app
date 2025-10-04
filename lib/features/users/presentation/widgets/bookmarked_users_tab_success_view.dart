import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/core/widgets/responsive_list_view.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_tile.dart';

class BookmarkedUsersTabSuccessView extends StatelessWidget {
  final ScrollController controller;
  final List<UserEntity> users;
  final bool isLoadingMore;
  final void Function(int id) onUserTap;
  final void Function(int id) onRemoveBookmark;
  final Future<void> Function() onRefresh;

  const BookmarkedUsersTabSuccessView({
    super.key,
    required this.controller,
    required this.users,
    required this.isLoadingMore,
    required this.onUserTap,
    required this.onRemoveBookmark,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: onRefresh,
        child: ResponsiveListView(
          key: const PageStorageKey('bookmarked_users_tab_list'),
          controller: controller,
          items: users,
          isLoadingMore: isLoadingMore,
          showDividers: true,
          itemBuilder: (context, user) {
            final badges = user.badgeCounts;

            return UserTile(
              key: ValueKey(user.id),
              avatarUrl: user.avatar,
              name: user.name,
              reputation: user.reputation,
              badges: (badges.gold, badges.silver, badges.bronze),
              bookmarked: true,
              onTap: () => onUserTap(user.id),
              onToggleBookmark: () => onRemoveBookmark(user.id),
            );
          },
        ),
      );
}
