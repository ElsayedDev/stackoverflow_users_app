import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:stackoverflow_users_app/core/error/failures.dart';
import 'package:stackoverflow_users_app/core/utils/app_logger.dart';

/// Wrap a Future action and convert thrown exceptions to Failure.
/// If [onFailure] is provided and returns a non-null value, that value is used
/// as a successful fallback (Right).
Future<Either<Failure, T>> execute<T>(
  Future<T> Function() action, {
  String? tag,
  FutureOr<T?> Function(Object error, StackTrace stack)? onFailure,
}) async {
  try {
    final result = await action();
    return right(result);
  } catch (e, s) {
    AppLogger.logError(context: 'execute', tag: tag, error: e, stack: s);

    if (onFailure != null) {
      try {
        final fallback = await onFailure(e, s);
        if (fallback != null) {
          return right(fallback);
        }
      } catch (fe, fs) {
        AppLogger.logError(
            context: 'execute.onFailure', tag: tag, error: fe, stack: fs);
      }
    }

    return left(Failure.fromException(e));
  }
}

/// Wrap a Stream source and map each event to Right(value).
/// If the stream throws and [onFailure] is provided, a single fallback value
/// will be emitted as Right before closing. Otherwise a single Left is emitted.
Stream<Either<Failure, T>> executeStream<T>(
  Stream<T> Function() source, {
  String? tag,
  FutureOr<T?> Function(Object error, StackTrace stack)? onFailure,
}) async* {
  try {
    await for (final value in source()) {
      yield right(value);
    }
  } catch (e, s) {
    AppLogger.logError(context: 'executeStream', tag: tag, error: e, stack: s);

    if (onFailure != null) {
      try {
        final fallback = await onFailure(e, s);
        if (fallback != null) {
          yield right(fallback);
          return; // close after emitting fallback
        }
      } catch (fe, fs) {
        AppLogger.logError(
            context: 'executeStream.onFailure', tag: tag, error: fe, stack: fs);
      }
    }

    yield left(Failure.fromException(e));
  }
}
