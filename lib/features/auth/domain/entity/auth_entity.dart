import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String fName;
  final String password;

  const AuthEntity({
    required this.email,
    this.userId,
    required this.fName,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, fName, password, email];
}
