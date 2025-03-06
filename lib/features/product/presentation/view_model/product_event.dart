part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class LoadProducts extends ProductEvent {}

final class LoadProduct extends ProductEvent {}

final class AddProduct extends ProductEvent {
  final String name;
  final String? description;
  final String? photo;

  const AddProduct(
      {required this.name, required this.description, required this.photo});

  @override
  List<Object?> get props => [name, description, photo];
}

final class DeleteProduct extends ProductEvent {
  final String id;

  const DeleteProduct({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UpdateProduct extends ProductEvent {
  final String id;
  final String name;
  final String? description;
  final String? photo;

  const UpdateProduct({
    required this.id,
    required this.name,
    this.description,
    this.photo,
  });

  @override
  List<Object?> get props => [id, name, description, photo];
}
