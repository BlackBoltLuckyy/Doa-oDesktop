// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item_model.dart';

StockItemModel _$StockItemModelFromJson(Map<String, dynamic> json) => StockItemModel(
      id: json['id'] as int,
      nome: json['nome'] as String,
      categoria: json['categoria'] as String,
      quantidade: json['quantidade'] as int,
      unidade: json['unidade'] as String,
      dataEntrada: DateTime.parse(json['dataEntrada'] as String),
      origemDoacaoId: json['origemDoacaoId'] as int?,
    );

Map<String, dynamic> _$StockItemModelToJson(StockItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'categoria': instance.categoria,
      'quantidade': instance.quantidade,
      'unidade': instance.unidade,
      'dataEntrada': instance.dataEntrada.toIso8601String(),
      'origemDoacaoId': instance.origemDoacaoId,
    };
