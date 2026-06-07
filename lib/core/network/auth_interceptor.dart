import 'package:dio/dio.dart';

import 'network_events.dart';

/// Intercepta cada requisição para injetar o token JWT e trata respostas 401.
class AuthInterceptor extends Interceptor {
  final Future<String?> Function() _tokenProvider;

  AuthInterceptor({required Future<String?> Function() tokenProvider})
      : _tokenProvider = tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenProvider();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      emitUnauthorized();
    }
    handler.next(err);
  }
}
