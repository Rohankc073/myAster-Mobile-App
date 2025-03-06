import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/app/shared_prefs/token_shared_prefs.dart';
import 'package:myAster/app/shared_prefs/user_shared_prefs.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/domain/repository/auth_repository.dart';
import 'package:myAster/features/auth/domain/use_case/login_use_case.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

class MockUserSharedPrefs extends Mock implements UserSharedPrefs {}

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late MockUserSharedPrefs userSharedPrefs;
  late LoginUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    userSharedPrefs = MockUserSharedPrefs();
    usecase = LoginUseCase(
      repository: repository,
      tokenSharedPrefs: tokenSharedPrefs,
      userSharedPrefs: userSharedPrefs,
    );

    registerFallbackValue(
      const LoginUserParams(email: 'test@gmail.com', password: 'test123'),
    );
  });

  test(
      'should call the [AuthRepo.loginUser] and return an AuthResponse on success',
      () async {
    const email = 'rohan@gmail.com';
    const password = 'rohan123';
    const authResponse = AuthResponse(
      token: 'mock_token',
      userId: 'user_123',
      name: 'Rohan KC',
      email: email,
      role: 'student',
    );

    when(() => repository.loginUser(email, password))
        .thenAnswer((_) async => const Right(authResponse));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => const Right(null));

    when(() => userSharedPrefs.saveUserData(any(), any(), any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result =
        await usecase(const LoginUserParams(email: email, password: password));

    expect(result, const Right(authResponse));

    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(authResponse.token)).called(1);
    verify(() => userSharedPrefs.saveUserData(authResponse.userId,
        authResponse.name, authResponse.email, authResponse.role)).called(1);
  });

  test('should return a failure when login fails', () async {
    when(() => repository.loginUser(any(), any())).thenAnswer(
      (_) async => const Left(ApiFailure(message: "Invalid login")),
    );

    final result = await usecase(
        const LoginUserParams(email: 'wrong@gmail.com', password: 'wrongPass'));

    expect(result, const Left(ApiFailure(message: "Invalid login")));

    verify(() => repository.loginUser(any(), any())).called(1);
    verifyNever(() => tokenSharedPrefs.saveToken(any()));
    verifyNever(() => userSharedPrefs.saveUserData(any(), any(), any(), any()));
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
    reset(userSharedPrefs);
  });
}
