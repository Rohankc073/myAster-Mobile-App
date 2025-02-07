part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage; // Added error message

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage, // Nullable error message
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ??
          this.errorMessage, // Preserve previous error if not updated
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        errorMessage
      ]; // ✅ Includes errorMessage for state comparison
}
