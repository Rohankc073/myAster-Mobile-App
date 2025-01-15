import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.initial()) {
    // Handle navigation to the Login screen
    on<NavigateToLoginScreenEvent>((event, emit) {
      _handleNavigationToLoginScreen(event);
    });
  }

  void _handleNavigationToLoginScreen(NavigateToLoginScreenEvent event) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) =>
            event.destination, // Destination widget (e.g., LoginPage)
      ),
    );
  }
}
