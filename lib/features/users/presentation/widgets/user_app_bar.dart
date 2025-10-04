import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/features/users/presentation/models/home_filter_option.dart';
import 'package:stackoverflow_users_app/gen/assets.gen.dart';
import 'package:stackoverflow_users_app/l10n/l10n.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    super.key,
    HomeFilterOption selectedOption = HomeFilterOption.all,
    ValueChanged<HomeFilterOption>? onFilterChanged,
  }) : super(
          leadingWidth: 56.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 12.h, bottom: 12.h),
            child: Assets.icons.icStackoverflow.svg(
              width: 24.r,
              height: 24.r,
            ),
          ),
          title: Text(S.current.appTitle),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<HomeFilterOption>(
                  segments: [
                    ButtonSegment<HomeFilterOption>(
                      value: HomeFilterOption.all,
                      label: Text(S.current.all),
                      icon: Icon(Icons.group_outlined),
                    ),
                    ButtonSegment<HomeFilterOption>(
                      value: HomeFilterOption.bookmarked,
                      label: Text(S.current.bookmarked),
                      icon: Icon(Icons.bookmark_rounded),
                    ),
                  ],
                  selected: <HomeFilterOption>{selectedOption},
                  onSelectionChanged: (selection) {
                    if (selection.isEmpty) return;
                    final selected = selection.first;
                    onFilterChanged?.call(selected);
                  },
                ),
              ),
            ),
          ),
        );
}
