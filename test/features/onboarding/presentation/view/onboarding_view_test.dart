import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:myAster/features/onboarding/presentation/view_model/onboarding_cubit.dart';

// ✅ Mock OnboardingCubit
class MockOnboardingCubit extends Mock implements OnboardingCubit {}

void main() {
  late MockOnboardingCubit mockOnboardingCubit;

  setUp(() {
    mockOnboardingCubit = MockOnboardingCubit();
  });

  testWidgets('✅ Displays text and button correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<OnboardingCubit>.value(
        value: mockOnboardingCubit,
        child: const MaterialApp(
          home: OnboardingView(),
        ),
      ),
    );

    // ✅ Check if title is displayed
    expect(find.text('Welcome to myAster'), findsOneWidget);

    // ✅ Check if description is displayed
    expect(
        find.text(
            'Your Health Companion. Manage your appointments, medications, and wellness.'),
        findsOneWidget);

    // ✅ Check if Get Started button is displayed
    expect(find.text('Get Started'), findsOneWidget);
  });

  // testWidgets('✅ Clicking "Get Started" calls navigation',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     BlocProvider<OnboardingCubit>.value(
  //       value: mockOnboardingCubit,
  //       child: const MaterialApp(
  //         home: OnboardingView(),
  //       ),
  //     ),
  //   );

  //   // ✅ Tap "Get Started" button
  //   await tester.tap(find.text('Get Started'));
  //   await tester.pump();

  //   // ✅ Verify that navigation function is called
  //   verify(() => mockOnboardingCubit.checkTokenAndNavigate(any())).called(1);
  // });
}
