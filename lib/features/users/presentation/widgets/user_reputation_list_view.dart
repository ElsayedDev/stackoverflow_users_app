import 'package:flutter/material.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/reputation_tile.dart';

class UserReputationListView extends StatelessWidget {
  final void Function(int postId) onPostOpened;
  final List<ReputationEntity> items;

  const UserReputationListView({
    super.key,
    required this.onPostOpened,
    required this.items,
  });

  @override
  Widget build(BuildContext context) => SliverList.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) {
          final item = items[i];
          return ReputationTile(
            item: item,
            onPostOpened: () => onPostOpened(item.postId),
          );
        },
      );
}
