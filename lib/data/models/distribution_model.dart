import 'package:json_annotation/json_annotation.dart';

part 'distribution_model.g.dart';

@JsonSerializable()
class DistributionModel {
  final int id;
  final int beneficiarioId;
  final String beneficiarioNome;
  final int operadorId;
  final DateTime dataDistribuicao;
  final List<DistributionItem> itens;
  final String? observacao;

  DistributionModel({
    required this.id,
    required this.beneficiarioId,
    required this.beneficiarioNome,
    required this.operadorId,
    required this.dataDistribuicao,
    required this.itens,
    this.observacao,
  });

  factory DistributionModel.fromJson(Map<String, dynamic> json) => _$DistributionModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistributionModelToJson(this);
}

@JsonSerializable()
class DistributionItem {
  final int estoqueItemId;
  final int quantidade;

  DistributionItem({
    required this.estoqueItemId,
    required this.quantidade,
  });

  factory DistributionItem.fromJson(Map<String, dynamic> json) => _$DistributionItemFromJson(json);
  Map<String, dynamic> toJson() => _$DistributionItemToJson(this);
}
