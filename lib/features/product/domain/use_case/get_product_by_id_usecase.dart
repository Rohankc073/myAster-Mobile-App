import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:myasteer/app/useccase/usecase.dart';
import 'package:myasteer/features/product/domain/entity/product_entity.dart';
import 'package:myasteer/features/product/domain/repository/doctor_repository.dart';

import '../../../../core/error/failure.dart';

class GetProductByIdParams extends Equatable {
  final String id;

  const GetProductByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetProductByIdUseCase
    implements UsecaseWithParams<ProductEntity, GetProductByIdParams> {
  final IProductRepository productRepository;

  GetProductByIdUseCase({required this.productRepository});

  @override
  Future<Either<Failure, ProductEntity>> call(
      GetProductByIdParams params) async {
    return productRepository.getProductById(params.id);
  }
}
