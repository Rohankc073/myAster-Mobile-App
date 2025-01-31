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

  @override
  List<Object?> get props => [userId, name, password, email, image, phone];
}
