import 'package:equatable/equatable.dart';

abstract class SingleProductEvent extends Equatable {
  const SingleProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadSingleProduct extends SingleProductEvent {
  final String productId;

  const LoadSingleProduct({required this.productId});

  @override
  List<Object?> get props => [productId];
}
