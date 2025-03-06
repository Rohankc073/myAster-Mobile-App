import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';
import 'package:myAster/features/auth/presentation/view/login_page.dart';
import 'package:myAster/features/auth/presentation/view_model/login/bloc/login_bloc.dart';
import 'package:myAster/features/auth/presentation/view_model/request_otp/request_otp_bloc.dart';
import 'package:myAster/features/auth/presentation/view_model/signup/bloc/signup_bloc.dart';
import 'package:myAster/features/home/presentation/view_model/cubit/home_cubit.dart';

// ✅ Mock Dependencies
class MockLoginUserUseCase extends Mock implements LoginUseCase {}

class MockSignupBloc extends Mock implements SignupBloc {}

class MockRequestOtpBloc extends Mock implements RequestOtpBloc {}

void main() {
  late LoginBloc loginBloc;
  late MockLoginUserUseCase loginUseCase;
  late MockSignupBloc signupBloc;
  late MockRequestOtpBloc requestOtpBloc;
  late HomeCubit homeCubit;

  setUp(() {
    loginUseCase = MockLoginUserUseCase();
    signupBloc = MockSignupBloc();
    requestOtpBloc = MockRequestOtpBloc();
    homeCubit = HomeCubit();

    loginBloc = LoginBloc(
      loginUseCase: loginUseCase,
      signupBloc: signupBloc,
      homeCubit: homeCubit,
      requestOtpBloc: requestOtpBloc,
    );

    registerFallbackValue(const LoginUserParams(email: '', password: ''));
  });

  // group('LoginBloc Tests', () {
  //   const validEmail = 'test@gmail.com';
  //   const validPassword = 'password123';
  //   const loginParams =
  //       LoginUserParams(email: validEmail, password: validPassword);

  //   const mockAuthResponse = AuthResponse(
  //     token: 'mock_token',
  //     userId: '12345',
  //     name: 'John Doe',
  //     email: validEmail,
  //     role: 'user',
  //   );

  //   blocTest<LoginBloc, LoginState>(
  //     '✅ Emits [isLoading=true, isSuccess=true] when login succeeds',
  //     build: () {
  //       when(() => loginUseCase.call(any()))
  //           .thenAnswer((_) async => const Right(mockAuthResponse));

  //       return loginBloc;
  //     },
  //     act: (bloc) => bloc.add(LoginUserEvent(
  //       email: validEmail,
  //       password: validPassword,
  //       context: MockBuildContext(),
  //       destination: const Dashboard(),
  //     )),
  //     expect: () => [
  //       LoginState.initial().copyWith(isLoading: true),
  //       LoginState.initial().copyWith(isLoading: false, isSuccess: true),
  //     ],
  //     verify: (_) {
  //       verify(() => loginUseCase.call(loginParams)).called(1);
  //     },
  //   );

  //   blocTest<LoginBloc, LoginState>(
  //     '❌ Emits [isLoading=true, isSuccess=false] when login fails',
  //     build: () {
  //       when(() => loginUseCase.call(any())).thenAnswer((_) async =>
  //           const Left(ApiFailure(message: 'Invalid credentials')));

  //       return loginBloc;
  //     },
  //     act: (bloc) => bloc.add(LoginUserEvent(
  //       email: validEmail,
  //       password: validPassword,
  //       context: MockBuildContext(),
  //       destination: const Dashboard(),
  //     )),
  //     expect: () => [
  //       LoginState.initial().copyWith(isLoading: true),
  //       LoginState.initial().copyWith(isLoading: false, isSuccess: false),
  //     ],
  //     verify: (_) {
  //       verify(() => loginUseCase.call(loginParams)).called(1);
  //     },
  //   );
  // });

  // tearDown(() {
  //   loginBloc.close();
  //   reset(loginUseCase);
  //   reset(signupBloc);
  //   reset(requestOtpBloc);
  // });

  testWidgets('📝 UI Test: Email and Password Validation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<LoginBloc>.value(
          value: loginBloc,
          child: LoginView(),
        ),
      ),
    );

    await tester.pumpAndSettle(); // ✅ Ensure UI is ready

    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));

    await tester.enterText(emailField, 'rohan@gmail.com');
    await tester.enterText(passwordField, 'password@123');

    await tester.pump();

    expect(find.text('rohan@gmail.com'), findsOneWidget);
    expect(find.text('password@123'), findsOneWidget);
  });

  // testWidgets('🚨 UI Test: Shows SnackBar when login fails',
  //     (WidgetTester tester) async {
  //   when(() => loginUseCase.call(any())).thenAnswer(
  //       (_) async => const Left(ApiFailure(message: 'Invalid credentials')));

  //   await tester.pumpWidget(
  //     MaterialApp(
  //       home: BlocProvider<LoginBloc>.value(
  //         value: loginBloc,
  //         child: LoginView(),
  //       ),
  //     ),
  //   );

  //   await tester.pumpAndSettle(); // ✅ Ensure UI is fully loaded

  //   final emailField = find.byKey(const Key('email'));
  //   final passwordField = find.byKey(const Key('password'));
  //   final loginButton = find.byKey(const Key('loginButton'));

  //   await tester.enterText(emailField, 'test@gmail.com');
  //   await tester.enterText(passwordField, 'password123');
  //   await tester.tap(loginButton);
  //   await tester.pumpAndSettle(); // ✅ Wait for SnackBar to show

  //   // ✅ Verify that a SnackBar is shown with the error message
  //   expect(find.textContaining('Invalid Credentials'), findsOneWidget);
  // });
}

// ✅ Mock BuildContext Class
class MockBuildContext extends Mock implements BuildContext {}
