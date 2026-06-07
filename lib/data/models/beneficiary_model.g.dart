// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_model.dart';

BeneficiaryModel _$BeneficiaryModelFromJson(Map<String, dynamic> json) => BeneficiaryModel(
      id: json['id'] as int,
      nome: json['nome'] as String,
      cpf: json['cpf'] as String,
      dataNascimento: DateTime.parse(json['dataNascimento'] as String),
      telefone: json['telefone'] as String,
      endereco: json['endereco'] as String,
      numeroDependentes: json['numeroDependentes'] as int,
      rendaFamiliar: (json['rendaFamiliar'] as num).toDouble(),
      necessidades: (json['necessidades'] as List<dynamic>?)?.map((e) => e as String).toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$BeneficiaryModelToJson(BeneficiaryModel instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'dataNascimento': instance.dataNascimento.toIso8601String(),
      'telefone': instance.telefone,
      'endereco': instance.endereco,
      'numeroDependentes': instance.numeroDependentes,
      'rendaFamiliar': instance.rendaFamiliar,
      'necessidades': instance.necessidades,
      'status': instance.status,
    };
