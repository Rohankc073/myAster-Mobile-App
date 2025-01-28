import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/presentation/view/signup_page.dart';
// import 'package:myasteer/features/auth/presentation/view/signup_view.dart'; // Update with the correct path
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';
// import 'package:myasteer/features/auth/presentation/view_model/signup/signup_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._signupBloc) : super(null);

  final SignupBloc _signupBloc;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _signupBloc,
              child: const SignUpPage(), // Replace with your SignupView widget
            ),
          ),
        );
      }
    });
  }
}
