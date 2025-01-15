import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignupBloc _signupBloc;
  // final HomeCubit _homeCubit;
  LoginBloc({
    required SignupBloc signupBloc,
    // required HomeCubit homeCubit,
  })  : _signupBloc = signupBloc,
        // _homeCubit = homeCubit,
        super(LoginState.initial()) {

          on<NavigateRegisterScreenEvent>((event, emit) => ,)
    // on<NavigateRegisterScreenEvent>((event, emit) {
    //   Navigator.push(
    //     event.context,
    //     MaterialPageRoute(
    //       builder: (context) => BlocProvider.value(
    //           value: _signupBloc, child: event.destination),
    //     ),
    //   );
    // });

    // on<NavigateHomeScreenEvent>((event, emit) {
    //   Navigator.pushReplacement(
    //     event.context,
    //     MaterialPageRoute(
    //       builder: (context) => BlocProvider.value(
    //         // value: _homeCubit,
    //         child: event.destination,
    //       ),
    //     ),
    //   );
    // });
  }
}
