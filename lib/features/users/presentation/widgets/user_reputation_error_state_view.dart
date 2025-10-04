import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/l10n/l10n.dart';

/// A reusable widget to display an error message with a retry button.
class UserReputationErrorStateView extends StatelessWidget {
  final String message;

  final VoidCallback? onRetry;

  const UserReputationErrorStateView({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16.h,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16.h),
              if (onRetry != null)
                ElevatedButton(
                  onPressed: onRetry,
                  child: Text(S.current.retry),
                ),
            ],
          ),
        ),
      );
}
