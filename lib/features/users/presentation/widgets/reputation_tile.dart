import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:stackoverflow_users_app/gen/colors.gen.dart';
import 'package:stackoverflow_users_app/features/users/domain/entities/reputation_entity.dart';
import 'package:stackoverflow_users_app/features/users/presentation/extensions/reputation_history_type_extension.dart';

class ReputationTile extends StatelessWidget {
  final ReputationEntity item;
  final VoidCallback onPostOpened;
  const ReputationTile({
    super.key,
    required this.item,
    required this.onPostOpened,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final changeColor =
        _isPositive ? ColorName.sofSuccess : ColorName.sofDanger;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorName.sofBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            offset: Offset(0, 2.h),
            blurRadius: 6.r,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 12.w,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: changeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              _changeText,
              style: textTheme.titleMedium?.copyWith(
                color: changeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.type.label,
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 4.h),
                Text(
                  _dateFormat.format(item.createdAt),
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: onPostOpened,
                  borderRadius: BorderRadius.circular(4.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 4.w,
                      children: [
                        Text(
                          'Post #${item.postId}',
                          style: textTheme.bodySmall?.copyWith(
                            color: ColorName.sofBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.open_in_new,
                          size: 14.sp,
                          color: ColorName.sofBlue,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------- Private ----------------------
  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy • HH:mm');

  String get _changeText {
    final change = item.change;
    final prefix = change > 0 ? '+' : '';
    return '$prefix$change';
  }

  bool get _isPositive => item.change >= 0 || item.type.isPositive;
}
