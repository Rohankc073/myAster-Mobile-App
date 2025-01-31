import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/auth/data/model/auth_api_model.dart';

part 'get_all_auth.g.dart';

@JsonSerializable()
class AuthDTO {
  final List<AuthApiModel> data;

  AuthDTO({required this.data});

  factory AuthDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDTOToJson(this);
}
