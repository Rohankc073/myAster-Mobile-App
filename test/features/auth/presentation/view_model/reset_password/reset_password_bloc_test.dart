import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/domain/use_case/reset_password_usecase.dart';
import 'package:myAster/features/auth/presentation/view_model/reset_password/reset_password_bloc.dart';

// ✅ Mock Dependencies
class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

void main() {
  late ResetPasswordBloc resetPasswordBloc;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUp(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    resetPasswordBloc =
        ResetPasswordBloc(resetPasswordUseCase: mockResetPasswordUseCase);

    registerFallbackValue(
        const ResetPasswordParams(email: '', otp: '', newPassword: ''));
  });

  const testEmail = 'test@gmail.com';
  const testOtp = '123456';
  const testNewPassword = 'newPassword@123';
  const testParams = ResetPasswordParams(
    email: testEmail,
    otp: testOtp,
    newPassword: testNewPassword,
  );

  group('ResetPasswordBloc Tests', () {
    blocTest<ResetPasswordBloc, ResetPasswordState>(
      '✅ Emits [isLoading=true, isSuccess=true] when password reset succeeds',
      build: () {
        when(() => mockResetPasswordUseCase.call(any())).thenAnswer((_) async =>
            const Right(unit)); // ✅ `unit` represents a void return

        return resetPasswordBloc;
      },
      act: (bloc) => bloc.add(const ResetPasswordSubmitted(
        email: testEmail,
        otp: testOtp,
        newPassword: testNewPassword,
      )),
      expect: () => [
        const ResetPasswordState(isLoading: true, isSuccess: false),
        const ResetPasswordState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockResetPasswordUseCase.call(testParams)).called(1);
      },
    );

    blocTest<ResetPasswordBloc, ResetPasswordState>(
      '❌ Emits [isLoading=true, isSuccess=false, errorMessage="Reset failed"] when password reset fails',
      build: () {
        when(() => mockResetPasswordUseCase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Reset failed')),
        );

        return resetPasswordBloc;
      },
      act: (bloc) => bloc.add(const ResetPasswordSubmitted(
        email: testEmail,
        otp: testOtp,
        newPassword: testNewPassword,
      )),
      expect: () => [
        const ResetPasswordState(isLoading: true, isSuccess: false),
        const ResetPasswordState(
            isLoading: false, isSuccess: false, errorMessage: "Reset failed"),
      ],
      verify: (_) {
        verify(() => mockResetPasswordUseCase.call(testParams)).called(1);
      },
    );
  });

  tearDown(() {
    resetPasswordBloc.close();
    reset(mockResetPasswordUseCase);
  });
}
