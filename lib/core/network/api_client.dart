import 'package:dio/dio.dart';

import '../config/app_config.dart';
import 'auth_interceptor.dart';
import 'error_handler.dart';

/// Cliente HTTP centralizado. O token é lido via [tokenProvider] a cada requisição,
/// garantindo que rotações de token sejam refletidas automaticamente.
class ApiClient {
  final Dio _dio;

  ApiClient({
    required AppConfig config,
    required Future<String?> Function() tokenProvider,
  }) : _dio = Dio(
          BaseOptions(
            baseUrl: config.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {'Content-Type': 'application/json'},
          ),
        ) {
    _dio.interceptors.add(
      AuthInterceptor(tokenProvider: tokenProvider),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(onError: ErrorHandler.handle),
    );
  }

  Dio get client => _dio;
}
