import 'dart:async';

/// Stream que emite um evento sempre que a API retorna 401 (sessão expirada).
/// Consumido pelo [AuthNotifier] para efetuar logout automático.
final StreamController<void> _unauthorizedController =
    StreamController<void>.broadcast();

Stream<void> get unauthorizedStream => _unauthorizedController.stream;

void emitUnauthorized() {
  if (!_unauthorizedController.isClosed) {
    _unauthorizedController.add(null);
  }
}
