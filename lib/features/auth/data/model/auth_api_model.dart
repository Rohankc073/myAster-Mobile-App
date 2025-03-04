import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myAster/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: 'userId')
  final String? userId;
  final String name;
  final String? image;
  final String email;
  final String password;
  final String phone;

  const AuthApiModel({
    this.userId,
    this.image,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  factory AuthApiModel.fromEntity(AuthEntity entity) => AuthApiModel(
        userId: entity.userId,
        email: entity.email,
        image: entity.image,
        name: entity.name,
        password: entity.password,
        phone: entity.phone,
      );
  AuthEntity toEntity() => AuthEntity(
      userId: userId,
      email: email,
      image: image,
      name: name,
      password: password,
      phone: phone);

  @override
  List<Object?> get props => [userId, name, password, phone, email, image];
}
