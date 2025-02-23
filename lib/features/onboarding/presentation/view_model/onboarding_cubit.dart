import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/app/shared_prefs/token_shared_prefs.dart';
import 'package:myasteer/features/auth/presentation/view/login_page.dart';
import 'package:myasteer/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:myasteer/features/home/presentation/view/home_view.dart';

class OnboardingCubit extends Cubit<void> {
  final LoginBloc _loginBloc;
  final TokenSharedPrefs _tokenSharedPrefs;

  OnboardingCubit(this._loginBloc, this._tokenSharedPrefs) : super(null);

  Future<void> checkTokenAndNavigate(BuildContext context) async {
    await Future.delayed(
        const Duration(seconds: 1)); // Optional delay for smooth transition

    final tokenResult = await _tokenSharedPrefs.getToken();

    tokenResult.fold(
      (failure) {
        // ❌ Log error & go to Login if token retrieval fails
        debugPrint("❌ Error fetching token: ${failure.message}");
        _goToLogin(context);
      },
      (String? token) {
        if (token != null && token.trim().isNotEmpty) {
          // ✅ Token exists, go to HomePage
          debugPrint("✅ Token found: Navigating to Home");
          _goToHome(context);
        } else {
          // ❌ No token, go to Login
          debugPrint("❌ No token found: Navigating to Login");
          _goToLogin(context);
        }
      },
    );
  }

  void _goToLogin(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _loginBloc,
            child: LoginView(),
          ),
        ),
      );
    }
  }

  void _goToHome(BuildContext context) {
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
    }
  }
}
