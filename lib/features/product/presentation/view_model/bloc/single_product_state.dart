import 'package:equatable/equatable.dart';
import 'package:myAster/features/product/domain/entity/product_entity.dart';

abstract class SingleProductState extends Equatable {
  const SingleProductState();

  @override
  List<Object?> get props => [];
}

class SingleProductInitial extends SingleProductState {}

class SingleProductLoading extends SingleProductState {}

class SingleProductLoaded extends SingleProductState {
  final ProductEntity product;

  const SingleProductLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class SingleProductError extends SingleProductState {
  final String message;

  const SingleProductError(this.message);

  @override
  List<Object?> get props => [message];
}
