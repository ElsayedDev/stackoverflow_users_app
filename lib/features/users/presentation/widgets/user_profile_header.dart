import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/avatar_placeholder.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/badge_dot.dart';
import 'package:stackoverflow_users_app/generated/colors.gen.dart';

/// Renders a user profile header including avatar, name, reputation,
/// optional location, and badge counts. Handles loading and error states.
class UserProfileHeader extends StatelessWidget {
  final UserEntity? user;
  final bool isLoading;
  final String? error;
  const UserProfileHeader({
    super.key,
    required this.user,
    required this.isLoading,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
    if (isLoading) {
      return Padding(
        padding: padding,
        child: const LinearProgressIndicator(),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    if (user == null) {
      final err = error?.trim();
      if (err == null || err.isEmpty) {
        return SizedBox(height: 8.h);
      }

      return Padding(
        padding: padding,
        child: Text(
          err,
          style: textTheme.bodyMedium?.copyWith(color: ColorName.sofDanger),
        ),
      );
    }

    final userData = user!;
    final badgeCounts = userData.badgeCounts;
    final location = userData.location?.trim();
    final rep = NumberFormat.decimalPattern().format(userData.reputation);

    return Padding(
      padding: padding,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorName.sofBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0, 4.h),
              blurRadius: 12.r,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.w,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: userData.avatar,
                width: 72.r,
                height: 72.r,
                fit: BoxFit.cover,
                placeholder: (context, url) => AvatarPlaceholder(size: 72.r),
                errorWidget: (context, url, error) =>
                    AvatarPlaceholder(size: 72.r),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.h,
                children: [
                  Text(
                    userData.name,
                    style: textTheme.titleLarge?.copyWith(
                      color: ColorName.sofBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Reputation: $rep',
                    style: textTheme.bodyMedium?.copyWith(
                      color: ColorName.sofMuted,
                    ),
                  ),
                  if (location != null && location.isNotEmpty) ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: ColorName.sofMuted,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            location,
                            style: textTheme.bodySmall?.copyWith(
                              color: ColorName.sofMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  Row(
                    spacing: 8.w,
                    children: [
                      BadgeDot(
                        color: ColorName.sofBadgeGold,
                        count: badgeCounts.gold,
                      ),
                      BadgeDot(
                        color: ColorName.sofBadgeSilver,
                        count: badgeCounts.silver,
                      ),
                      BadgeDot(
                        color: ColorName.sofBadgeBronze,
                        count: badgeCounts.bronze,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
