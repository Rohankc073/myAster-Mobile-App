import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/presentation/view/login_page.dart';
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // App Logo
              Image.asset(
                'assets/images/Logo.png',
                height: 300,
                width: 300,
              ),
              // Heading
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3579FF),
                  fontFamily: 'Rockwell',
                ),
              ),
              const SizedBox(height: 30),

              // Name TextField
              const CustomTextField(
                hintText: "Your Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              // Email TextField
              const CustomTextField(
                hintText: "Your Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 20),

              // Password TextField
              const CustomTextField(
                hintText: "Password",
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Confirm Password TextField
              const CustomTextField(
                hintText: "Confirm Password",
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add sign-up action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3579FF),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Rockwell",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // OR Divider
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Google and Facebook Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/facebook.png",
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/google.png",
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Sign In Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontFamily: 'Rockwell'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Dispatch the NavigateToLoginScreenEvent
                      context.read<SignupBloc>().add(
                            NavigateToLoginScreenEvent(
                              context: context,
                              destination: const LoginPage(),
                            ),
                          );
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFF3579FF),
                        fontFamily: 'Rockwell',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: hintText,
        labelStyle: const TextStyle(
          fontFamily: 'Rockwell',
          fontSize: 14,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Rockwell',
          fontSize: 14,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
      ),
    );
  }
}
