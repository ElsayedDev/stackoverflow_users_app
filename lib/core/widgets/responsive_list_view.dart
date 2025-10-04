import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/widgets/loading_center.dart';

class ResponsiveListView<T extends Object> extends StatelessWidget {
  final ScrollController? controller;
  final List<T> items;
  final bool isLoadingMore;
  final Widget Function(BuildContext, T) itemBuilder;
  final bool showDividers;

  const ResponsiveListView({
    super.key,
    this.controller,
    required this.items,
    required this.isLoadingMore,
    required this.itemBuilder,
    required this.showDividers,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    // Target ~360 logical px per tile in landscape; portrait forces 1 col.
    final maxExtent = isPortrait ? mediaQuery.size.width : 200.w;

    return GridView.builder(
      key: super.key,
      controller: controller,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: isPortrait ? 0 : 16.r,
        vertical: isPortrait ? 0 : 12.r,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxExtent,
        mainAxisExtent: isPortrait ? 70.h : 100.h,
        crossAxisSpacing: isPortrait ? 0 : 12.r,
        mainAxisSpacing: isPortrait ? 0 : 12.r,
      ),
      itemCount: items.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // loading footer cell
        if (index >= items.length) {
          return const LoadingCenter();
        }

        final item = items[index];

        return Column(
          children: [
            Expanded(child: itemBuilder(context, item)),
            // list-style dividers only when single column
            if (showDividers && isPortrait)
              Divider(height: 1.h, color: Theme.of(context).dividerColor),
          ],
        );
      },
    );
  }
}
