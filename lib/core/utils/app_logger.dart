import 'dart:developer';
import 'package:flutter/foundation.dart';

abstract class AppLogger {
  static void logError({
    required String context,
    String? tag,
    required Object error,
    required StackTrace stack,
  }) {
    if (!kDebugMode) return;
    log('❌ Error in $context${tag != null ? ' [$tag]' : ''}',
        error: error, stackTrace: stack);
  }
}
