import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stackoverflow_users_app/core/network/stack_exchange_key_interceptor.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final options = BaseOptions(
      baseUrl: 'https://api.stackexchange.com/2.2/',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      queryParameters: const {
        'site': 'stackoverflow',
      },
      headers: const {
        'Accept': 'application/json',
        'Accept-Language': 'en-US,en;q=0.9',
      },
    );

    final dio = Dio(options);

    dio.interceptors.add(
        StackExchangeKeyInterceptor(dotenv.env['STACK_EXCHANGE_KEY'] ?? ''));

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}
