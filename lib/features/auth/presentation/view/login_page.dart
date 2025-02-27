import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/auth/presentation/view/signup_page.dart';
import 'package:myasteer/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:myasteer/features/home/presentation/view/home_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "admin@gmail.com");
  final _passwordController = TextEditingController(text: "admin123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/images/login-i.png',
                      height: 250,
                      width: 250,
                    ),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontFamily: 'Monserrat',
                      ),
                    ),
                    const SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Input
                          TextFormField(
                            key: const ValueKey('email'),
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Enter Your Email',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                              final emailRegex =
                                  RegExp(r"^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                              // if (!emailRegex.hasMatch(value)) {
                              //   return "Enter a valid email";
                              // }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Password Input
                          TextFormField(
                            key: const ValueKey('password'),
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Enter Your Password',
                              suffixIcon: const Icon(Icons.visibility_off),
                            ),
                            // validator: (value) {
                            //   if (value == null || value.trim().isEmpty) {
                            //     return "Password is required";
                            //   }
                            //   if (value.length < 8) {
                            //     return "Password must be at least 8 characters";
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(height: 10),

                          // Forgot Password link
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Login Button with Gradient
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final email = _emailController.text.trim();
                                  final password =
                                      _passwordController.text.trim();

                                  // Navigate to Home screen
                                  context.read<LoginBloc>().add(
                                        LoginUserEvent(
                                          context: context,
                                          email: email,
                                          password: password,
                                          destination: const Dashboard(),
                                        ),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                // shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                key: ValueKey('loginButton'),
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Monserrat",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Divider
                    const Row(
                      children: [
                        Expanded(
                            child: Divider(thickness: 1, color: Colors.grey)),
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
                            child: Divider(thickness: 1, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Sign Up prompt with underline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account? "),
                        TextButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    context: context,
                                    destination: const SignUpPage(),
                                  ),
                                );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFF3579FF),
                              fontFamily: 'Monserrat',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
