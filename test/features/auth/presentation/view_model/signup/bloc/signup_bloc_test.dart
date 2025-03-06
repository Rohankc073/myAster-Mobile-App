import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/features/auth/domain/use_case/signup_use_case.dart';
import 'package:myAster/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:myAster/features/auth/presentation/view/signup_page.dart';
import 'package:myAster/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';

// Mock dependencies
class MockSignupBloc extends Mock implements SignupBloc {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

void main() {
  late SignupBloc signupBloc;
  late RegisterUseCase registerUseCase;
  late UploadImageUsecase uploadImageUsecase;

  setUp(() {
    registerUseCase = MockRegisterUseCase();
    uploadImageUsecase = MockUploadImageUsecase();
    signupBloc = SignupBloc(
      registerUseCase: registerUseCase,
      uploadImageUsecase: uploadImageUsecase,
    );
  });

  // testWidgets('Signup form validation', (WidgetTester tester) async {
  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider<SignupBloc>.value(
  //         value: signupBloc,
  //         child: const SignUpPage(),
  //       ),
  //     ),
  //   );

  //   // Find text fields
  //   final nameField = find.byKey(const Key('name'));
  //   final emailField = find.byKey(const Key('email'));
  //   final phoneField = find.byKey(const Key('phone'));
  //   final passwordField = find.byKey(const Key('password'));
  //   final signupButton = find.byKey(const Key('signupButton'));

  //   // Enter invalid data
  //   await tester.enterText(nameField, '');
  //   await tester.enterText(emailField, 'invalid-email');
  //   await tester.enterText(phoneField, '123');
  //   await tester.enterText(passwordField, 'sht');

  //   // Tap the signup button
  //   await tester.tap(signupButton);
  //   await tester.pump();

  //   // Check for validation messages
  //   expect(find.text('Please enter Your Name'), findsOneWidget);
  //   expect(find.text('Enter a valid email'), findsOneWidget);
  //   expect(find.text('Enter a valid phone number'), findsOneWidget);
  //   expect(find.text('Password must be at least 8 characters'), findsOneWidget);
  // });

  testWidgets('Signup with valid data', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SignupBloc>.value(
          value: signupBloc,
          child: const SignUpPage(),
        ),
      ),
    );

    // Find text fields
    final nameField = find.byKey(const Key('name'));
    final emailField = find.byKey(const Key('email'));
    final phoneField = find.byKey(const Key('phone'));
    final passwordField = find.byKey(const Key('password'));
    final signupButton = find.byKey(const Key('signupButton'));

    // Enter valid data
    await tester.enterText(nameField, 'John Doe');
    await tester.enterText(emailField, 'john.doe@example.com');
    await tester.enterText(phoneField, '1234567890');
    await tester.enterText(passwordField, 'password123');

    // Tap the signup button
    await tester.tap(signupButton);
    await tester.pump();

    // Verify that no validation errors are shown
    expect(find.text('Please enter Your Name'), findsNothing);
    expect(find.text('Enter a valid email'), findsNothing);
    expect(find.text('Enter a valid phone number'), findsNothing);
    expect(find.text('Password must be at least 8 characters'), findsNothing);
  });
}
