import 'package:json_annotation/json_annotation.dart';

part 'beneficiary_model.g.dart';

@JsonSerializable()
class BeneficiaryModel {
  final int id;
  final String nome;
  final String cpf;
  final DateTime dataNascimento;
  final String telefone;
  final String endereco;
  final int numeroDependentes;
  final double rendaFamiliar;
  final List<String>? necessidades;
  final String status;

  BeneficiaryModel({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.telefone,
    required this.endereco,
    required this.numeroDependentes,
    required this.rendaFamiliar,
    this.necessidades,
    required this.status,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) => _$BeneficiaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeneficiaryModelToJson(this);
}
