import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myAster/core/error/failure.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';
import 'package:myAster/features/product/domain/repository/product_repository.dart';
import 'package:myAster/features/product/domain/use_case/get_all_product_usecase.dart';

class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;
  late GetAllProductsUseCase usecase;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetAllProductsUseCase(productRepository: mockProductRepository);
  });

  final List<ProductEntity> mockProducts = [
    const ProductEntity(
      id: "1",
      name: "Paracetamol",
      genericName: "Acetaminophen",
      manufacturer: "XYZ Pharma",
      image: "paracetamol.jpg",
      price: 10.0,
      description: "Used for pain relief and fever reduction",
    ),
    const ProductEntity(
      id: "2",
      name: "Ibuprofen",
      genericName: "Ibuprofen",
      manufacturer: "ABC Pharmaceuticals",
      image: "ibuprofen.jpg",
      price: 15.0,
      description: "Used for inflammation and pain relief",
    ),
  ];

  test('✅ Should return a list of products when the call is successful',
      () async {
    // Arrange
    when(() => mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(mockProducts));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(mockProducts));
    verify(() => mockProductRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('❌ Should return a Failure when the call is unsuccessful', () async {
    // Arrange
    when(() => mockProductRepository.getAllProducts()).thenAnswer((_) async =>
        const Left(ServerFailure(message: "Failed to fetch products")));

    // Act
    final result = await usecase();

    // Assert
    expect(
        result, const Left(ServerFailure(message: "Failed to fetch products")));
    verify(() => mockProductRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('⚠️ Should return an empty list if no products are available', () async {
    // Arrange
    const emptyList = <ProductEntity>[]; // ✅ Explicitly define empty list

    when(() => mockProductRepository.getAllProducts()).thenAnswer(
        (_) async => const Right(emptyList)); // ✅ Use defined emptyList

    // Act
    final result = await usecase();

    // Assert
    expect(result, const Right(emptyList)); // ✅ Use the same defined emptyList
    verify(() => mockProductRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  test('🔄 Should call getAllProducts only once', () async {
    // Arrange
    when(() => mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(mockProducts));

    // Act
    await usecase();

    // Assert
    verify(() => mockProductRepository.getAllProducts()).called(1);
  });

  test('🚫 Should not call any other repository method', () async {
    // Arrange
    when(() => mockProductRepository.getAllProducts())
        .thenAnswer((_) async => Right(mockProducts));

    // Act
    await usecase();

    // Assert
    verify(() => mockProductRepository.getAllProducts()).called(1);
    verifyNoMoreInteractions(mockProductRepository);
  });

  tearDown(() {
    reset(mockProductRepository);
  });
}
