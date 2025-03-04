import 'package:bloc/bloc.dart';
import 'package:myAster/features/product/domain/use_case/get_product_by_id_usecase.dart';

import 'single_product_event.dart';
import 'single_product_state.dart';

class SingleProductBloc extends Bloc<SingleProductEvent, SingleProductState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  SingleProductBloc({required GetProductByIdUseCase getProductByIdUseCase})
      : _getProductByIdUseCase = getProductByIdUseCase,
        super(SingleProductInitial()) {
    on<LoadSingleProduct>(_onLoadSingleProduct);
  }

  Future<void> _onLoadSingleProduct(
      LoadSingleProduct event, Emitter<SingleProductState> emit) async {
    emit(SingleProductLoading());

    final result = await _getProductByIdUseCase.call(
      GetProductByIdParams(productId: event.productId),
    );

    result.fold(
      (failure) => emit(SingleProductError(failure.message)),
      (product) => emit(SingleProductLoaded(product: product)),
    );
  }
}
