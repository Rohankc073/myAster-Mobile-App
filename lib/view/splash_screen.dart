import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              height: screenHeight * .9, // 25% of screen height
              width: screenWidth * .9, // 50% of screen width
            ),
          ],
        ),
      ),
    );
  }
}
