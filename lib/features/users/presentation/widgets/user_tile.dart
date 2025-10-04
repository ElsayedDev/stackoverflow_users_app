import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/core/widgets/animated_scaling_button.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/avatar_placeholder.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/badge_dot.dart';
import 'package:stackoverflow_users_app/gen/colors.gen.dart';

class UserTile extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final int reputation;
  final (int gold, int silver, int bronze) badges;
  final bool bookmarked;
  final VoidCallback onTap;
  final VoidCallback onToggleBookmark;

  const UserTile({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.reputation,
    required this.badges, // (gold, silver, bronze)
    required this.bookmarked,
    required this.onTap,
    required this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AnimatedScalingButton(
      onPressed: onTap,
      scale: 0.98,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
        decoration: BoxDecoration(
          color: bookmarked
              ? ColorName.sofOrange.withValues(alpha: 0.1)
              : Colors.white,
        ),
        child: Row(
          spacing: 12.r,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: CachedNetworkImage(
                imageUrl: avatarUrl,
                width: 48.r,
                height: 48.r,
                fit: BoxFit.cover,
                fadeInDuration: Duration.zero,
                fadeOutDuration: Duration.zero,
                placeholder: (context, url) => AvatarPlaceholder(size: 48.r),
                errorWidget: (context, url, error) =>
                    AvatarPlaceholder(size: 48.r),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 4.h,
                children: [
                  // Name link-style
                  Text(
                    name,
                    style: t.titleMedium?.copyWith(color: ColorName.sofBlue),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        _k(reputation),
                        style:
                            t.bodyMedium?.copyWith(color: ColorName.sofMuted),
                      ),
                      8.horizontalSpace,
                      BadgeDot(
                        color: ColorName.sofBadgeGold,
                        count: badges.$1,
                      ),
                      6.horizontalSpace,
                      BadgeDot(
                        color: ColorName.sofBadgeSilver,
                        count: badges.$2,
                      ),
                      6.horizontalSpace,
                      BadgeDot(
                        color: ColorName.sofBadgeBronze,
                        count: badges.$3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onToggleBookmark,
              splashRadius: 20.r,
              icon: Icon(
                bookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: bookmarked ? ColorName.sofOrange : ColorName.sofMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------- Private ----------------------
  String _k(int n) => n.toString(); // replace with NumberFormat if you want
}
