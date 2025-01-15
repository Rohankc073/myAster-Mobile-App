import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/app/di/di.dart';
import 'package:myasteer/core/app_theme/theme_data.dart';
import 'package:myasteer/features/splash/presentation/view/splash_view.dart';
import 'package:myasteer/features/splash/presentation/view_model/cubit/splash_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider.value(
        value: getIt<SplashCubit>(),
        child: const SplashScreen(),
      ),
    );
  }
}
