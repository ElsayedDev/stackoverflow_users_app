import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/widgets/loading_center.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/sliver_group.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_reputation_grid_view.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/user_reputation_list_view.dart';

/// Decides list vs grid responsively and renders items + footer loader as a Sliver.
class ReputationListSliver extends StatelessWidget {
  final List<ReputationEntity> items;
  final bool isLoadingMore;
  final void Function(int postId) onPostOpened;

  const ReputationListSliver({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.onPostOpened,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final columns = (mediaQuery.size.width / 420).floor().clamp(1, 4);
    final useGrid = isLandscape && columns > 1;

    final sliver = useGrid
        ? UserReputationGridView(
            onPostOpened: onPostOpened,
            columns: columns,
            items: items,
          )
        : UserReputationListView(
            onPostOpened: onPostOpened,
            items: items,
          );

    final children = <Widget>[
      sliver,
      if (isLoadingMore)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: const LoadingCenter(),
          ),
        ),
    ];

    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          SliverGroup(children: children),
        ],
      ),
    );
  }
}
