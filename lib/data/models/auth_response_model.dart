import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'auth_response_model.g.dart';

/// Hipótese de contrato: o backend retorna { "token": "...", "usuario": { ... } }
/// no endpoint POST /auth/login. Ajustar conforme o schema real da API.
@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final String token;
  final UserModel usuario;

  AuthResponseModel({
    required this.token,
    required this.usuario,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}
