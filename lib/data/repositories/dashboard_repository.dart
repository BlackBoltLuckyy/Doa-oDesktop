import '../../core/network/api_client.dart';
import '../../core/utils/either.dart';
import '../models/dashboard_stats_model.dart';

class DashboardRepository {
  // ignore: unused_field
  final ApiClient _apiClient;

  DashboardRepository(this._apiClient);

  Future<Either<String, DashboardStatsModel>> getStats() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const Right(DashboardStatsModel(
      doacoesPendentes: 24,
      doacoesAprovadas: 18,
      itensEstoque: 312,
      beneficiariosAtivos: 96,
      distribuicoesNoMes: 42,
      tendenciaPendentes: '+12% nas últimas 24h',
      tendenciaPendentesPositiva: false,
      tendenciaAprovadas: '+8% vs. semana anterior',
      tendenciaAprovadasPositiva: true,
      tendenciaDistribuicoes: '+5 hoje',
      tendenciaDistribuicoesPositiva: true,
      atividadeRecente: [
        ActivityItem(doador: 'Maria Silva', item: 'Casacos', categoria: 'Roupas', status: 'PENDENTE', data: '07/06/2026'),
        ActivityItem(doador: 'João Costa', item: 'Cesta básica', categoria: 'Alimentos', status: 'APROVADO', data: '07/06/2026'),
        ActivityItem(doador: 'Ana Souza', item: 'Tênis', categoria: 'Calçados', status: 'EM_ESTOQUE', data: '06/06/2026'),
        ActivityItem(doador: 'Pedro Alves', item: 'Cadeiras', categoria: 'Móveis', status: 'RECUSADO', data: '06/06/2026'),
        ActivityItem(doador: 'Carla Lima', item: 'Livros', categoria: 'Educação', status: 'PENDENTE', data: '05/06/2026'),
      ],
      doacoesValores: [12, 20, 18, 9, 6],
      doacoesCategorias: ['Roupas', 'Alimentos', 'Móveis', 'Eletrônicos', 'Outros'],
      estoquePorCategoria: {
        'Roupas': 28,
        'Alimentos': 34,
        'Móveis': 18,
        'Eletrônicos': 10,
        'Outros': 10,
      },
    ));
  }
}
