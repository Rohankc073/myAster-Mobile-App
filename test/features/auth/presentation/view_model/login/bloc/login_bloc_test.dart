// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:myasteer/core/error/failure.dart';
// import 'package:myasteer/features/auth/domain/use_case/login_use_case.dart';
// import 'package:myasteer/features/auth/presentation/view/login_page.dart';
// import 'package:myasteer/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
// import 'package:myasteer/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';
// import 'package:myasteer/features/home/presentation/view_model/cubit/home_cubit.dart';

// // Mock dependencies
// class MockLoginUserUsecase extends Mock implements LoginUseCase {}

// class MockSignupBloc extends Mock implements SignupBloc {}

// void main() {
//   late LoginBloc loginBloc;
//   late MockLoginUserUsecase loginUsecase;
//   late MockSignupBloc signupBloc;

//   setUp(() {
//     loginUsecase = MockLoginUserUsecase();
//     signupBloc = MockSignupBloc();
//     loginBloc = LoginBloc(
//         loginUseCase: loginUsecase,
//         signupBloc: signupBloc,
//         homeCubit: HomeCubit());

//     registerFallbackValue(const LoginUserParams(email: '', password: ''));
//   });

//   group('LoginBloc Tests', () {
//     const validEmail = 'test@gmail.com';
//     const validPassword = 'password';
//     const loginParams =
//         LoginUserParams(email: validEmail, password: validPassword);

//     blocTest<LoginBloc, LoginState>(
//       'emits [isLoading=true, isSuccess=true] when login succeeds',
//       build: () {
//         when(() => loginUsecase.call(any()))
//             .thenAnswer((_) async => const Right(null)); // ✅ No user object
//         return loginBloc;
//       },
//       act: (bloc) => bloc.add(
//           const LoginUserEvent(email: validEmail, password: validPassword)),
//       expect: () => [
//         LoginState.initial().copyWith(isLoading: true),
//         LoginState.initial().copyWith(isLoading: false, isSuccess: true),
//       ],
//       verify: (_) {
//         verify(() => loginUsecase.call(loginParams)).called(1);
//       },
//     );

//     blocTest<LoginBloc, LoginState>(
//       'emits [isLoading=true, isSuccess=false, errorMessage="Invalid credentials"] when login fails',
//       build: () {
//         when(() => loginUsecase.call(any())).thenAnswer((_) async =>
//             const Left(ApiFailure(message: 'Invalid credentials')));
//         return loginBloc;
//       },
//       act: (bloc) => bloc.add(
//           const LoginUserEvent(email: validEmail, password: validPassword)),
//       expect: () => [
//         LoginState.initial().copyWith(isLoading: true),
//         LoginState.initial().copyWith(
//             isLoading: false,
//             isSuccess: false,
//             errorMessage: "Invalid credentials"),
//       ],
//       verify: (_) {
//         verify(() => loginUsecase.call(loginParams)).called(1);
//       },
//     );
//   });

//   tearDown(() {
//     loginBloc.close();
//     reset(loginUsecase);
//     reset(signupBloc);
//   });

//   testWidgets('Email and Password Validation', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: LoginView(),
//         ),
//       ),
//     );

//     final emailField = find.byKey(const Key('email'));
//     final passwordField = find.byKey(const Key('password'));

//     await tester.enterText(emailField, 'rohan@gmail.com');
//     await tester.enterText(passwordField, 'password@123');

//     await tester.pump();

//     expect(find.text('rohan@gmail.com'), findsOneWidget);
//     expect(find.text('password@123'), findsOneWidget);
//   });

//   testWidgets('Invalid Email and Password Validation',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: BlocProvider<LoginBloc>.value(
//           value: loginBloc,
//           child: LoginView(),
//         ),
//       ),
//     );

//     final emailField = find.byKey(const Key('email'));
//     final passwordField = find.byKey(const Key('password'));
//     final loginButton = find.byKey(const Key('loginButton'));

//     await tester.enterText(emailField, 'invalid-email');
//     await tester.enterText(passwordField, 'short');

//     await tester.pump();

//     await tester.tap(loginButton);
//     await tester.pump();

//     expect(find.text('Enter a valid email'), findsOneWidget);
//     expect(find.text('Password must be at least 8 characters'), findsOneWidget);
//   });
// }
