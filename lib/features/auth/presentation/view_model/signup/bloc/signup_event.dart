part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends SignupEvent {
  final BuildContext context;
  final String email;
  final String name;
  final String phone;
  final String password;

  const RegisterUser({
    required this.context,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });
}

// class NavigateLoginScreenEvent extends SignupEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateLoginScreenEvent({
//     required this.context,
//     required this.destination,
//   });
// }
