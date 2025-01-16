import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.initial()) {
    on<NavigateToLoginScreenEvent>(_onNavigateToLoginScreenEvent);
  }

  void _onNavigateToLoginScreenEvent(
    NavigateToLoginScreenEvent event,
    Emitter<SignupState> emit,
  ) {
    // Perform navigation using Navigator.push
    Navigator.push(
      event.context,
      MaterialPageRoute(builder: (context) => event.destination),
    );

    // Optionally, emit a new state if needed
    // emit(NavigateToLoginScreenState());
  }
}
