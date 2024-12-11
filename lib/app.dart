import 'package:flutter/material.dart';
import 'package:myasteer/view/login_page.dart';
import 'package:myasteer/view/signup_page.dart';
import 'package:myasteer/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}
