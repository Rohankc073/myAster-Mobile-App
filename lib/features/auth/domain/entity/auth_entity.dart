import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String name;
  final String email;
  final String password;
  final String phone;

  const AuthEntity({
    required this.name,
    this.userId,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [userId, name, password, email];
}
