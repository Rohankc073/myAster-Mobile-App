import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Replace with the correct path to your login page file

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to Login Page after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
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
            // Responsive logo image
            Image.asset(
              'assets/images/Logo.png',
              height: screenHeight * .9, // 90% of screen height
              width: screenWidth * .9, // 90% of screen width
            ),
          ],
        ),
      ),
    );
  }
}
