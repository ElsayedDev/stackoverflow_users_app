import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stackoverflow_users_app/generated/l10n.dart';

class EmptyStateView extends StatelessWidget {
  final String message;
  final String? subMessage;
  final VoidCallback? onRefresh; // pull-to-refresh
  final VoidCallback? onRetry; // button tap
  final String retryLabel;
  final Widget? illustration; // optional icon/image

  const EmptyStateView({
    super.key,
    required this.message,
    this.subMessage,
    this.onRefresh,
    this.onRetry,
    this.retryLabel = 'Retry', // Default value
    this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    final content = ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        120.verticalSpace,
        Center(
          child: Column(
            children: [
              if (illustration != null) ...[
                illustration!,
                16.verticalSpace,
              ],
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (subMessage?.isNotEmpty == true) ...[
                8.verticalSpace,
                Text(
                  subMessage!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).hintColor),
                ),
              ],
              if (onRetry != null) ...[
                16.verticalSpace,
                ElevatedButton(
                  onPressed: onRetry,
                  child: Text(
                      retryLabel == 'Retry' ? S.current.retry : retryLabel),
                ),
              ],
            ],
          ),
        ),
      ],
    );

    // Wrap with RefreshIndicator only if refresh callback provided
    return onRefresh == null
        ? content
        : RefreshIndicator(onRefresh: () async => onRefresh!(), child: content);
  }
}
