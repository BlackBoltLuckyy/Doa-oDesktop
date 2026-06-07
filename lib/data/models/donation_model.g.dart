// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_model.dart';

DonationModel _$DonationModelFromJson(Map<String, dynamic> json) => DonationModel(
      id: json['id'] as int,
      doador: json['doador'] as String,
      descricao: json['descricao'] as String,
      categoria: json['categoria'] as String,
      status: json['status'] as String,
      criadoEm: DateTime.parse(json['criadoEm'] as String),
      fotos: (json['fotos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DonationModelToJson(DonationModel instance) => <String, dynamic>{
      'id': instance.id,
      'doador': instance.doador,
      'descricao': instance.descricao,
      'categoria': instance.categoria,
      'status': instance.status,
      'criadoEm': instance.criadoEm.toIso8601String(),
      'fotos': instance.fotos,
    };
