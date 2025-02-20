import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myasteer/features/user/domain/entity/user_entity.dart';

part 'user_api_model.g.dart';

// Include the generated part file.

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? contact;
  final String? email;
  final String image;
  final String specialization;

  const UserApiModel({
    this.id,
    required this.name,
    this.contact,
    this.email,
    required this.image,
    required this.specialization,
  });

  const UserApiModel.empty()
      : id = '',
        name = '',
        contact = '',
        image = '',
        specialization = '',
        email = null;

  // From JSON
  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  // Convert API Object to Entity
  UserEntity toEntity() => UserEntity(
        id: id,
        name: name,
        image: image,
        contact: contact,
        email: email,
        specialization: specialization,
      );

  // Convert Entity to API Object
  factory UserApiModel.fromEntity(UserEntity user) {
    return UserApiModel(
      id: user.id,
      image: user.image,
      name: user.name,
      contact: user.contact,
      email: user.email,
      specialization: user.specialization,
    );
  }

  // Convert API List to Entity List
  static List<UserEntity> toEntityList(List<UserApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [id, name, image, email, contact, specialization];
}
