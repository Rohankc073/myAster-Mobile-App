import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/core/common/snackbar/my_snackbar.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';
import 'package:myAster/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';
import 'package:myAster/features/home/presentation/view_model/cubit/home_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignupBloc _signupBloc;
  final HomeCubit _homeCubit;

  final LoginUseCase _loginUseCase;

  LoginBloc({
    required SignupBloc signupBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
  })  : _signupBloc = signupBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _signupBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });

    // Toggle password visibitlity
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    // Handle login event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final params = LoginUserParams(
        email: event.email,
        password: event.password,
      );

      final result = await _loginUseCase.call(params);

      result.fold(
        (failure) {
          // If the failure has a message, use it; otherwise, use a fallback
          String errorMessage = failure.message;

          // Handle failure (update the state with error message or show a failure alert)
          emit(state.copyWith(isLoading: false, isSuccess: false));

          showMySnackBar(
            context: event.context,
            // message: errorMessage,
            message: 'Invalid Credentials: $errorMessage',
            color: const Color(0xFF9B6763),
          );
        },
        (user) {
          // On success, update state and navigate to the home screen
          emit(state.copyWith(isLoading: false, isSuccess: true));

          // Trigger navigation
          add(
            NavigateHomeScreenEvent(
              context: event.context,
              destination: event.destination,
            ),
          );
        },
      );
    });
  }
}
