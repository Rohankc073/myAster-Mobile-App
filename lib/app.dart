import 'package:flutter/material.dart';
import 'package:myasteer/core/app_theme/theme_data.dart';
import 'package:myasteer/view/login_page.dart';
import 'package:myasteer/view/onboarding_screen.dart';
import 'package:myasteer/view/signup_page.dart';
import 'package:myasteer/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: '/', // Set SplashScreen as the initial route
      routes: {
        '/': (context) =>
            const SplashScreen(), // SplashScreen is the first screen
        '/onboarding': (context) => OnboardingScreen(), // Onboarding screen
        '/login': (context) => const LoginPage(), // Login screen
        '/signup': (context) => const SignUpPage(), // Sign-up screen
      },
    );
  }
}
