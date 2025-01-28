import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myasteer/features/auth/presentation/view/login_page.dart';
import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isNameFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    Hive.initFlutter(); // Ensure Hive is initialized
  }

  void _saveUserData() async {
    if (passwordController.text != confirmPasswordController.text) {
      _showSnackbar("Passwords do not match!", Colors.red);
      return;
    }

    var userBox = await Hive.openBox('users');

    userBox.put(emailController.text, {
      "name": nameController.text,
      "email": emailController.text,
      "password":
          passwordController.text, // Store password securely in real apps
    });

    _showSnackbar("Account created successfully!", Colors.green);

    // Navigate to Login Page after delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Top Image
              SizedBox(
                height: 300,
                width: 300,
                child:
                    Image.asset('assets/images/login-i.png', fit: BoxFit.cover),
              ),
              const SizedBox(height: 10),

              // Create Account Heading
              const Text(
                "Create An Account",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3579FF),
                  fontFamily: 'Rockwell',
                ),
              ),
              const SizedBox(height: 20),

              // Input Fields
              _buildTextField(
                controller: nameController,
                icon: Icons.person,
                labelText: "Your Name",
                hintText: "Enter your name",
                isFocused: _isNameFocused,
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isNameFocused = hasFocus;
                  });
                },
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: emailController,
                icon: Icons.email,
                labelText: "Your Email",
                hintText: "Enter your email",
                isFocused: _isEmailFocused,
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isEmailFocused = hasFocus;
                  });
                },
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                controller: passwordController,
                labelText: "Password",
                hintText: "Enter your password",
                isPasswordVisible: _isPasswordVisible,
                isFocused: _isPasswordFocused,
                onVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isPasswordFocused = hasFocus;
                  });
                },
              ),
              const SizedBox(height: 20),

              _buildPasswordField(
                controller: confirmPasswordController,
                labelText: "Confirm Password",
                hintText: "Re-enter your password",
                isPasswordVisible: _isConfirmPasswordVisible,
                isFocused: _isConfirmPasswordFocused,
                onVisibilityToggle: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isConfirmPasswordFocused = hasFocus;
                  });
                },
              ),
              const SizedBox(height: 30),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveUserData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3579FF),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Rockwell",
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
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
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 30),

              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/facebook.png",
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 60),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/images/google.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontFamily: 'Rockwell'),
                  ),
                  TextButton(
                    onPressed: () {
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

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
    required String hintText,
    required bool isFocused,
    required Function(bool) onFocusChange,
  }) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: isFocused ? null : Icon(icon, size: 18),
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required bool isPasswordVisible,
    required bool isFocused,
    required VoidCallback onVisibilityToggle,
    required Function(bool) onFocusChange,
  }) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextField(
        controller: controller,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: isFocused ? null : const Icon(Icons.lock, size: 18),
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(fontSize: 13, color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          suffixIcon: IconButton(
            icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: onVisibilityToggle,
          ),
        ),
      ),
    );
  }
}
