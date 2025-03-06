import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;

  final String name;
  final String email;
  final String? image;
  final String password;
  final String phone;

  const AuthEntity({
    required this.name,
    this.userId,
    required this.email,
    required this.password,
    required this.phone,
    this.image,
  });

  const AuthEntity.empty()
      : name = "_empty.name",
        userId = '_empty.userId',
        image = '_empty.image',
        email = '_empty.email',
        password = "_empty.password",
        phone = '_empty.phone';

  @override
  List<Object?> get props => [userId, name, password, email, image, phone];
}
