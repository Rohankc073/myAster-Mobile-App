import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // Replace with the correct path to your onboarding screen file

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to Onboarding Screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });

    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive logo image with increased size
            Image.asset(
              'assets/images/Logo.png',
              height: screenHeight *
                  0.9, // Increased to occupy 50% of screen height
              width:
                  screenWidth * 0.9, // Increased to occupy 80% of screen width
            ),
          ],
        ),
      ),
    );
  }
}
