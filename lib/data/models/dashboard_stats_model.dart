class ActivityItem {
  final String doador;
  final String item;
  final String categoria;
  final String status;
  final String data;

  const ActivityItem({
    required this.doador,
    required this.item,
    required this.categoria,
    required this.status,
    required this.data,
  });
}

class DashboardStatsModel {
  final int doacoesPendentes;
  final int doacoesAprovadas;
  final int itensEstoque;
  final int beneficiariosAtivos;
  final int distribuicoesNoMes;
  final String? tendenciaPendentes;
  final bool tendenciaPendentesPositiva;
  final String? tendenciaAprovadas;
  final bool tendenciaAprovadasPositiva;
  final String? tendenciaDistribuicoes;
  final bool tendenciaDistribuicoesPositiva;
  final List<ActivityItem> atividadeRecente;
  final List<double> doacoesValores;
  final List<String> doacoesCategorias;
  final Map<String, double> estoquePorCategoria;

  const DashboardStatsModel({
    required this.doacoesPendentes,
    required this.doacoesAprovadas,
    required this.itensEstoque,
    required this.beneficiariosAtivos,
    required this.distribuicoesNoMes,
    this.tendenciaPendentes,
    this.tendenciaPendentesPositiva = false,
    this.tendenciaAprovadas,
    this.tendenciaAprovadasPositiva = true,
    this.tendenciaDistribuicoes,
    this.tendenciaDistribuicoesPositiva = true,
    required this.atividadeRecente,
    required this.doacoesValores,
    required this.doacoesCategorias,
    required this.estoquePorCategoria,
  });
}
