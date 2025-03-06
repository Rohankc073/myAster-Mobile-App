import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/auth/domain/use_case/upload_image_usecase.dart';

import 'login_use_case_test.dart';

class MockFile extends Mock implements File {}

void main() {
  late UploadImageUsecase useCase;
  late MockAuthRepository repository;
  late MockFile mockFile;

  setUp(() {
    repository = MockAuthRepository();
    mockFile = MockFile();
    useCase = UploadImageUsecase(repository);
  });

  test('should call uploadProfilePicture in the repository with correct params',
      () async {
    // Arrange
    const String imageUrl = 'https://example.com/profile.png';
    when(() => repository.uploadProfilePicture(mockFile))
        .thenAnswer((_) async => const Right(imageUrl));

    // Act
    final result = await useCase(UploadImageParams(file: mockFile));

    // Assert
    expect(result, const Right(imageUrl));
    verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(Failure) when image upload fails', () async {
    // Arrange
    const failure = ApiFailure(message: 'Image upload failed');
    when(() => repository.uploadProfilePicture(mockFile))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(UploadImageParams(file: mockFile));

    // Assert
    expect(result, const Left(failure));
    verify(() => repository.uploadProfilePicture(mockFile)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
