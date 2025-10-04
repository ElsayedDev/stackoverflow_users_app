import 'package:dio/dio.dart';

class StackExchangeKeyInterceptor extends Interceptor {
  final String apiKey;

  StackExchangeKeyInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final query = Map<String, dynamic>.from(options.queryParameters);
    query['key'] = apiKey; // add your Stack Apps key
    options.queryParameters = query;
    super.onRequest(options, handler);
  }
}
