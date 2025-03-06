part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends SignupEvent {
  final File file;

  const LoadImage({required this.file});

  @override
  List<Object> get props => [file];
}

class RegisterUser extends SignupEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  const RegisterUser({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, phone, password];
}
