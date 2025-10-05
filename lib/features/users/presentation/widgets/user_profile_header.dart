import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/user_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/avatar_placeholder.dart';
import 'package:stackoverflow_users_app/features/users/presentation/widgets/badge_dot.dart';
import 'package:stackoverflow_users_app/generated/colors.gen.dart';

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
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: const LinearProgressIndicator(),
      );
    }

    if (user == null) {
      if (error == null) {
        return const SizedBox(height: 8);
      }

      final textTheme = Theme.of(context).textTheme;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Text(
          error!,
          style: textTheme.bodyMedium?.copyWith(color: ColorName.sofDanger),
        ),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    final userData = user!;
    final badgeCounts = userData.badgeCounts;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorName.sofBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: Offset(0, 4.h),
              blurRadius: 12.r,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData.name,
                    style: textTheme.titleLarge?.copyWith(
                      color: ColorName.sofBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Reputation: ${userData.reputation}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: ColorName.sofMuted,
                    ),
                  ),
                  if (userData.location != null) ...[
                    SizedBox(height: 6.h),
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
                            userData.location!,
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
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      BadgeDot(
                        color: ColorName.sofBadgeGold,
                        count: badgeCounts.gold,
                      ),
                      SizedBox(width: 8.w),
                      BadgeDot(
                        color: ColorName.sofBadgeSilver,
                        count: badgeCounts.silver,
                      ),
                      SizedBox(width: 8.w),
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
