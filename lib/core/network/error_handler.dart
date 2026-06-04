import 'package:dio/dio.dart';

class ErrorHandler {
  ErrorHandler._();

  static void handle(DioException error, ErrorInterceptorHandler handler) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      handler.next(DioException(requestOptions: error.requestOptions, error: 'Servidor não respondeu. Verifique sua conexão.'));
      return;
    }

    if (error.response?.statusCode == 401) {
      handler.next(DioException(requestOptions: error.requestOptions, error: 'Sua sessão expirou. Faça login novamente.'));
      return;
    }

    if (error.response?.statusCode == 403) {
      handler.next(DioException(requestOptions: error.requestOptions, error: 'Você não tem permissão para realizar esta ação.'));
      return;
    }

    handler.next(error);
  }
}
