import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/features/splash/presentation/view_model/cubit/splash_cubit.dart';

// import 'package:myasteer/features/splash/presentation/view_model/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().init(context); // Initialize navigation logic
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Logo.png', // Replace with your actual logo path
                  height: screenHeight * 0.5, // Occupy 50% of screen height
                  width: screenWidth * 0.8, // Occupy 80% of screen width
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                const Text('Version: 1.0.0'),
              ],
            ),
          ),
          // Footer
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 4,
            child: const Text(
              'Developed by: Rohan KC', // Replace with your name
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
