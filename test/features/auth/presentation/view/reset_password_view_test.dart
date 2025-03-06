// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:myAster/features/auth/presentation/view/reset_password_view.dart';
// import 'package:myAster/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
// import 'package:myAster/features/auth/presentation/view_model/reset_password/reset_password_bloc.dart';
// import 'package:pinput/pinput.dart';

// // ✅ Mock Dependencies
// class MockResetPasswordBloc extends Mock implements ResetPasswordBloc {}

// class MockLoginBloc extends Mock implements LoginBloc {}

// void main() {
//   late MockResetPasswordBloc mockResetPasswordBloc;
//   late MockLoginBloc mockLoginBloc;

//   setUp(() {
//     mockResetPasswordBloc = MockResetPasswordBloc();
//     mockLoginBloc = MockLoginBloc();
//     registerFallbackValue(const ResetPasswordSubmitted(
//       email: 'test@gmail.com',
//       otp: '123456',
//       newPassword: 'Password123',
//     ));
//   });

//   Widget createTestWidget() {
//     return MaterialApp(
//       home: BlocProvider<ResetPasswordBloc>.value(
//         value: mockResetPasswordBloc,
//         child: const ResetPasswordView(email: 'test@gmail.com'),
//       ),
//     );
//   }

//   group('ResetPasswordView Widget Tests', () {
//     testWidgets('✅ Displays all fields and buttons',
//         (WidgetTester tester) async {
//       when(() => mockResetPasswordBloc.state)
//           .thenReturn(const ResetPasswordState(isLoading: false));

//       await tester.pumpWidget(createTestWidget());

//       // ✅ Check all UI elements exist
//       expect(find.text('Reset Password'), findsOneWidget);
//       expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password
//       expect(find.byType(Pinput), findsOneWidget); // OTP Field
//       expect(find.text('Set New Password'), findsOneWidget);
//     });

//     testWidgets('🚨 Shows validation errors when fields are empty',
//         (WidgetTester tester) async {
//       when(() => mockResetPasswordBloc.state)
//           .thenReturn(const ResetPasswordState(isLoading: false));

//       await tester.pumpWidget(createTestWidget());

//       final submitButton = find.text('Set New Password');

//       await tester.tap(submitButton);
//       await tester.pump();

//       expect(find.text('Enter a valid (6-Digit) OTP sent in your email'),
//           findsOneWidget);
//       expect(find.text('Enter a new password'), findsOneWidget);
//     });

//     testWidgets('✅ Submits form when valid inputs are provided',
//         (WidgetTester tester) async {
//       when(() => mockResetPasswordBloc.state)
//           .thenReturn(const ResetPasswordState(isLoading: false));

//       await tester.pumpWidget(createTestWidget());

//       final otpField = find.byType(Pinput);
//       final passwordField = find.byType(TextFormField).last;
//       final submitButton = find.text('Set New Password');

//       await tester.enterText(otpField, '123456');
//       await tester.enterText(passwordField, 'Password123');
//       await tester.tap(submitButton);
//       await tester.pump();

//       verify(() => mockResetPasswordBloc
//           .add(any(that: isA<ResetPasswordSubmitted>()))).called(1);
//     });

//     testWidgets('✅ Shows success SnackBar when password reset is successful',
//         (WidgetTester tester) async {
//       whenListen(
//         mockResetPasswordBloc,
//         Stream.fromIterable(
//             [const ResetPasswordState(isLoading: false, isSuccess: true)]),
//       );

//       await tester.pumpWidget(createTestWidget());
//       await tester.pump();

//       expect(find.text('Password reset successfully!'), findsOneWidget);
//     });

//     testWidgets('🚨 Shows error SnackBar when password reset fails',
//         (WidgetTester tester) async {
//       whenListen(
//         mockResetPasswordBloc,
//         Stream.fromIterable([
//           const ResetPasswordState(
//               isLoading: false, isSuccess: false, errorMessage: "Reset failed")
//         ]),
//       );

//       await tester.pumpWidget(createTestWidget());
//       await tester.pump();

//       expect(find.text('Reset failed'), findsOneWidget);
//     });
//   });
// }
