import 'package:dio/dio.dart';

class ErrorHandler {
  ErrorHandler._();

  static void handle(DioException error, ErrorInterceptorHandler handler) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      handler.next(
        DioException(
          requestOptions: error.requestOptions,
          error: 'Servidor não respondeu. Verifique sua conexão.',
          type: error.type,
        ),
      );
      return;
    }

    if (error.response?.statusCode == 403) {
      handler.next(
        DioException(
          requestOptions: error.requestOptions,
          error: 'Você não tem permissão para realizar esta ação.',
          response: error.response,
          type: error.type,
        ),
      );
      return;
    }

    handler.next(error);
  }

  /// Extrai a mensagem de erro de uma [DioException].
  /// Tenta ler o campo "mensagem" do body JSON antes de usar a mensagem padrão.
  static String extractMessage(DioException e, String fallback) {
    final body = e.response?.data;
    if (body is Map) {
      final msg = body['mensagem'] ?? body['message'] ?? body['error'];
      if (msg is String && msg.isNotEmpty) return msg;
    }
    return e.error?.toString() ?? fallback;
  }
}
