import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/presentation/view/signup_page.dart';
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';

class OnboardingCubit extends Cubit<void> {
  OnboardingCubit(this._signupBloc) : super(null);

  final SignupBloc _signupBloc;

  Future<void> goToLogin(BuildContext context) async {
    // Add any delay if necessary
    await Future.delayed(const Duration(seconds: 1), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _signupBloc,
              child: const SignUpPage(),
            ),
          ),
        );
      }
    });
  }
}
