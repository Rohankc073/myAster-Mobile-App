import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/domain/use_case/get_otp_usecase.dart';
import 'package:myAster/features/auth/presentation/view_model/request_otp/request_otp_bloc.dart';

// ✅ Mock Dependencies
class MockGetOtpUseCase extends Mock implements GetOtpUseCase {}

void main() {
  late RequestOtpBloc requestOtpBloc;
  late MockGetOtpUseCase mockGetOtpUseCase;

  setUp(() {
    mockGetOtpUseCase = MockGetOtpUseCase();
    requestOtpBloc = RequestOtpBloc(getOtpUseCase: mockGetOtpUseCase);

    registerFallbackValue(const GetOtpParams(email: ''));
  });

  const testEmail = 'test@gmail.com';
  const testParams = GetOtpParams(email: testEmail);

  group('RequestOtpBloc Tests', () {
    blocTest<RequestOtpBloc, RequestOtpState>(
      '✅ Emits [isLoading=true, isSuccess=true] when OTP request succeeds',
      build: () {
        when(() => mockGetOtpUseCase.call(any())).thenAnswer(
            (_) async => const Right("OTP sent successfully")); // ✅ Fixed type

        return requestOtpBloc;
      },
      act: (bloc) => bloc.add(const RequestOtpSubmitted(email: testEmail)),
      expect: () => [
        const RequestOtpState(isLoading: true, isSuccess: false),
        const RequestOtpState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockGetOtpUseCase.call(testParams)).called(1);
      },
    );

    blocTest<RequestOtpBloc, RequestOtpState>(
      '❌ Emits [isLoading=true, isSuccess=false, errorMessage="OTP request failed"] when OTP request fails',
      build: () {
        when(() => mockGetOtpUseCase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'OTP request failed')),
        );

        return requestOtpBloc;
      },
      act: (bloc) => bloc.add(const RequestOtpSubmitted(email: testEmail)),
      expect: () => [
        const RequestOtpState(isLoading: true, isSuccess: false),
        const RequestOtpState(
            isLoading: false,
            isSuccess: false,
            errorMessage: "OTP request failed"),
      ],
      verify: (_) {
        verify(() => mockGetOtpUseCase.call(testParams)).called(1);
      },
    );
  });

  tearDown(() {
    requestOtpBloc.close();
    reset(mockGetOtpUseCase);
  });
}
