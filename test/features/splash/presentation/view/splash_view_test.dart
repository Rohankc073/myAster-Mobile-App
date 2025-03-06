// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:myAster/features/onboarding/presentation/view/onboarding_view.dart';
// import 'package:myAster/features/splash/presentation/view/splash_view.dart';
// import 'package:myAster/features/splash/presentation/view_model/cubit/splash_cubit.dart';

// // ✅ Mock SplashCubit
// class MockSplashCubit extends Mock implements SplashCubit {}

// void main() {
//   late MockSplashCubit mockSplashCubit;

//   setUp(() {
//     mockSplashCubit = MockSplashCubit();
//   });

//   testWidgets('✅ Displays logo, loader, and version number',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       BlocProvider<SplashCubit>.value(
//         value: mockSplashCubit,
//         child: const MaterialApp(
//           home: SplashScreen(),
//         ),
//       ),
//     );

//     // Verify logo exists
//     expect(find.byType(Image), findsOneWidget);

//     // Verify loading indicator exists
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);

//     // Verify version text
//     expect(find.text('Version: 1.0.0'), findsOneWidget);
//   });

//   testWidgets('✅ Navigates to OnboardingView after delay',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       BlocProvider<SplashCubit>.value(
//         value: mockSplashCubit,
//         child: const MaterialApp(
//           home: SplashScreen(),
//         ),
//       ),
//     );

//     // Wait for navigation delay (2 seconds)
//     await tester.pump(const Duration(seconds: 2));

//     // Ensure OnboardingView is pushed
//     expect(find.byType(OnboardingView), findsOneWidget);
//   });
// }
