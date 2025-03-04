import 'package:equatable/equatable.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? error;
  final bool isImageLoading;
  final bool isImageSuccess;
  final String? imageName;

  const ProductState({
    required this.products,
    required this.isLoading,
    this.error,
    required this.isImageLoading,
    required this.isImageSuccess,
    this.imageName,
  });

  factory ProductState.initial() {
    return const ProductState(
      products: [],
      isLoading: false,
      isImageLoading: false,
      isImageSuccess: false,
      imageName: null,
    );
  }

  ProductState copyWith({
    List<ProductEntity>? categories,
    bool? isLoading,
    String? error,
    bool? isImageLoading,
    bool? isImageSuccess,
    String? imageName,
  }) {
    return ProductState(
      products: categories ?? products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isImageSuccess: isImageSuccess ?? this.isImageSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isLoading,
        error,
        isImageLoading,
        isImageSuccess,
        imageName,
      ];
}
