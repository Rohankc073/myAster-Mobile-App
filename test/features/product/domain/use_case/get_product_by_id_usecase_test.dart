import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';
import 'package:myAster/features/product/domain/repository/product_repository.dart';
import 'package:myAster/features/product/domain/use_case/get_product_by_id_usecase.dart';

class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;
  late GetProductByIdUseCase usecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProductByIdUseCase(productRepository: mockProductRepository);
    registerFallbackValue(const GetProductByIdParams(productId: "test-id"));
  });

  const String productId = "123";
  const ProductEntity mockProduct = ProductEntity(
    id: "123",
    name: "Test Product",
    image: "https://example.com/image.png",
    price: 99.99,
    description: "A sample product for testing",
    genericName: "TestGeneric",
    manufacturer: "TestManufacturer",
  );

  test('✅ Should return product when a valid ID is provided', () async {
    // Arrange
    when(() => mockProductRepository.getProductById(any()))
        .thenAnswer((_) async => const Right(mockProduct));

    // Act
    final result =
        await usecase(const GetProductByIdParams(productId: productId));

    // Assert
    expect(result, const Right(mockProduct));
    verify(() => mockProductRepository.getProductById(productId)).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('❌ Should return a Failure when product ID is invalid', () async {
    // Arrange
    when(() => mockProductRepository.getProductById(any())).thenAnswer(
        (_) async => const Left(ServerFailure(message: "Product not found")));

    // Act
    final result =
        await usecase(const GetProductByIdParams(productId: "invalid-id"));

    // Assert
    expect(result, const Left(ServerFailure(message: "Product not found")));
    verify(() => mockProductRepository.getProductById("invalid-id")).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('⚠️ Should return a Failure when the repository throws an error',
      () async {
    // Arrange
    when(() => mockProductRepository.getProductById(any()))
        .thenThrow(Exception("Unexpected error"));

    // Act
    final result =
        await usecase(const GetProductByIdParams(productId: productId));

    // Assert
    expect(result.isLeft(), true); // Ensure it returns a failure
    verify(() => mockProductRepository.getProductById(productId)).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  tearDown(() {
    reset(mockProductRepository);
  });
}
