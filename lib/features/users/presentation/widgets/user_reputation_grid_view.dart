import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/reputation_tile.dart';

class UserReputationGridView extends StatelessWidget {
  final void Function(int postId) onPostOpened;
  final int columns;
  final List<ReputationEntity> items;

  const UserReputationGridView({
    super.key,
    required this.onPostOpened,
    required this.columns,
    required this.items,
  });

  @override
  Widget build(BuildContext context) => SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final item = items[index];
            return ReputationTile(
              item: item,
              onPostOpened: () => onPostOpened(item.postId),
            );
          },
          childCount: items.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 2.8.r,
        ),
      );
}
