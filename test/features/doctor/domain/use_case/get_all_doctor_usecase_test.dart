import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/doctor/domain/entity/doctor_entity.dart';
import 'package:myAster/features/doctor/domain/repository/doctor_repository.dart';
import 'package:myAster/features/doctor/domain/use_case/get_all_doctor_usecase.dart';

class MockDoctorRepository extends Mock implements IDoctorRepository {}

void main() {
  late MockDoctorRepository mockDoctorRepository;
  late GetAllDoctorsUseCase usecase;

  setUp(() {
    mockDoctorRepository = MockDoctorRepository();
    usecase = GetAllDoctorsUseCase(doctorRepository: mockDoctorRepository);
  });

  final List<DoctorEntity> mockDoctors = [
    const DoctorEntity(
      id: "1",
      name: "Dr. John Doe",
      specialization: "Cardiologist",
      image: "image1.jpg",
      email: "johndoe@gmail.com",
      contact: "1234567890",
    ),
    const DoctorEntity(
      id: "2",
      name: "Dr. Jane Smith",
      specialization: "Neurologist",
      image: "image2.jpg",
      email: "janesmith@gmail.com",
      contact: "9876543210",
    ),
  ];

  test('should return a list of doctors when the call is successful', () async {
    // Arrange
    when(() => mockDoctorRepository.getAllDoctors())
        .thenAnswer((_) async => Right(mockDoctors));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(mockDoctors));
    verify(() => mockDoctorRepository.getAllDoctors()).called(1);
    verifyNoMoreInteractions(mockDoctorRepository);
  });

  test('should return a Failure when the call is unsuccessful', () async {
    // Arrange
    when(() => mockDoctorRepository.getAllDoctors()).thenAnswer((_) async =>
        const Left(ServerFailure(message: "Error fetching doctors")));

    // Act
    final result = await usecase();

    // Assert
    expect(
        result, const Left(ServerFailure(message: "Error fetching doctors")));
    verify(() => mockDoctorRepository.getAllDoctors()).called(1);
    verifyNoMoreInteractions(mockDoctorRepository);
  });

  tearDown(() {
    reset(mockDoctorRepository);
  });
}
