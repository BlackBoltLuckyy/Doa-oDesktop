import 'package:json_annotation/json_annotation.dart';

part 'stock_item_model.g.dart';

@JsonSerializable()
class StockItemModel {
  final int id;
  final String nome;
  final String categoria;
  final int quantidade;
  final String unidade;
  final DateTime dataEntrada;
  final int? origemDoacaoId;

  StockItemModel({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.quantidade,
    required this.unidade,
    required this.dataEntrada,
    this.origemDoacaoId,
  });

  factory StockItemModel.fromJson(Map<String, dynamic> json) => _$StockItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockItemModelToJson(this);
}
