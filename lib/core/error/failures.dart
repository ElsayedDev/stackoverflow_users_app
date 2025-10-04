import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

/// Base Failure class
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$runtimeType: $message';

  /// Factory to map any Exception/Error to a Failure
  factory Failure.fromException(Object e) {
    if (e is DioException) {
      return ServerFailure.fromStatusCode(e.response?.statusCode ?? 500);
    }

    // if (e is CacheException) {
    //   return CacheFailure(e.message);
    // }

    return UnknownFailure(e.toString());
  }
}

/// Server-related failures (API, Dio, Http)
class ServerFailure extends Failure {
  const ServerFailure(super.message);

  /// Create a failure based on HTTP status code
  factory ServerFailure.fromStatusCode(int statusCode, [String? message]) =>
      switch (statusCode) {
        400 => ServerFailure(message ??
            "Bad request – The server could not understand the request."),
        401 => ServerFailure(
            message ?? "Unauthorized – Please check your credentials."),
        403 => ServerFailure(message ??
            "Forbidden – You don’t have permission to access this resource."),
        404 => ServerFailure(message ??
            "Not found – The requested resource could not be found."),
        408 => ServerFailure(message ??
            "Request timeout – The server timed out waiting for the request."),
        500 => ServerFailure(message ??
            "Internal server error – Something went wrong on the server."),
        502 => ServerFailure(
            message ?? "Bad gateway – Invalid response from upstream server."),
        503 => ServerFailure(message ??
            "Service unavailable – The server is currently overloaded or down."),
        504 => ServerFailure(message ??
            "Gateway timeout – The upstream server failed to respond."),
        _ => ServerFailure(message ?? "Unexpected server error.")
      };
}

/// Cache-related failures (Hive, SharedPref, etc.)
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Unknown or unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
