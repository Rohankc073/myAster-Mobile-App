import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/domain/use_case/login_use_case.dart';
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final SignupBloc _signupBloc;

  LoginBloc({
    required LoginUseCase loginUseCase,
    required SignupBloc signupBloc,
  })  : _loginUseCase = loginUseCase,
        _signupBloc = signupBloc,
        super(LoginState.initial()) {
    // Register event handlers
    on<NavigateRegisterScreenEvent>(_handleNavigationToRegisterScreen);
    on<LoginUserEvent>(_handleLoginUser);
  }

  // Navigation to Register Screen
  void _handleNavigationToRegisterScreen(
      NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => event.destination, // SignUpPage
      ),
    );
  }

  // Login Event Handler
  Future<void> _handleLoginUser(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final params = LoginUserParams(
      email: event.email,
      password: event.password,
    );

    final result = await _loginUseCase.call(params);

    result.fold(
      (failure) {
        String errorMessage = failure.message ?? "Login failed. Try again.";

        // Logging the failure
        debugPrint('Login failed: $errorMessage');

        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: errorMessage,
        ));
      },
      (user) {
        debugPrint('Login successful!');

        emit(state.copyWith(
            isLoading: false, isSuccess: true, errorMessage: null));
      },
    );
  }
}
