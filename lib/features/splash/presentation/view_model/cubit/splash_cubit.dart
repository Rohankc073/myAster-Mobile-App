import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:myAster/features/onboarding/presentation/view_model/onboarding_cubit.dart';

import '../../../../../app/di/di.dart';
// import 'package:myasteer/features/auth/presentation/view_model/signup/signup_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5), () async {
      // Ensure context is mounted before navigating
      if (context.mounted) {
        // Navigate to OnboardingView wrapped in BlocProvider
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              // Provide OnboardingCubit using getIt
              return BlocProvider<OnboardingCubit>(
                create: (_) => getIt<OnboardingCubit>(),
                // Ensure OnboardingCubit is available
                child: const OnboardingView(), // Navigate to OnboardingView
              );
            },
          ),
        );
      }
    });
  }
}
