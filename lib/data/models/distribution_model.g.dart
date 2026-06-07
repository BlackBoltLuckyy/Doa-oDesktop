// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution_model.dart';

DistributionModel _$DistributionModelFromJson(Map<String, dynamic> json) => DistributionModel(
      id: json['id'] as int,
      beneficiarioId: json['beneficiarioId'] as int,
      beneficiarioNome: json['beneficiarioNome'] as String,
      operadorId: json['operadorId'] as int,
      dataDistribuicao: DateTime.parse(json['dataDistribuicao'] as String),
      itens: (json['itens'] as List<dynamic>).map((e) => DistributionItem.fromJson(e as Map<String, dynamic>)).toList(),
      observacao: json['observacao'] as String?,
    );

Map<String, dynamic> _$DistributionModelToJson(DistributionModel instance) => <String, dynamic>{
      'id': instance.id,
      'beneficiarioId': instance.beneficiarioId,
      'beneficiarioNome': instance.beneficiarioNome,
      'operadorId': instance.operadorId,
      'dataDistribuicao': instance.dataDistribuicao.toIso8601String(),
      'itens': instance.itens.map((e) => e.toJson()).toList(),
      'observacao': instance.observacao,
    };

DistributionItem _$DistributionItemFromJson(Map<String, dynamic> json) => DistributionItem(
      estoqueItemId: json['estoqueItemId'] as int,
      quantidade: json['quantidade'] as int,
    );

Map<String, dynamic> _$DistributionItemToJson(DistributionItem instance) => <String, dynamic>{
      'estoqueItemId': instance.estoqueItemId,
      'quantidade': instance.quantidade,
    };
