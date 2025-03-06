part of 'signup_bloc.dart';

class SignupState {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final String? errorMessage;

  SignupState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
    this.errorMessage,
  });

  SignupState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        errorMessage = null;

  SignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
    String? errorMessage,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
