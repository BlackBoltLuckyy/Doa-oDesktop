import 'package:dio/dio.dart';

import '../config/app_config.dart';
import 'auth_interceptor.dart';
import 'error_handler.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(AppConfig config, String? token)
      : _dio = Dio(BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        )) {
    _dio.interceptors.add(AuthInterceptor(token));
    _dio.interceptors.add(InterceptorsWrapper(onError: ErrorHandler.handle));
  }

  Dio get client => _dio;
}
