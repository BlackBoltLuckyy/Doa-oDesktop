import 'package:json_annotation/json_annotation.dart';

part 'donation_model.g.dart';

@JsonSerializable()
class DonationModel {
  final int id;
  final String doador;
  final String descricao;
  final String categoria;
  final String status;
  final DateTime criadoEm;
  final List<String>? fotos;

  DonationModel({
    required this.id,
    required this.doador,
    required this.descricao,
    required this.categoria,
    required this.status,
    required this.criadoEm,
    this.fotos,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) => _$DonationModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationModelToJson(this);
}
