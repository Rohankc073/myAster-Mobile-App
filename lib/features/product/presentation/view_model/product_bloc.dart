import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/features/product/domain/use_case/get_all_product_usecase.dart';
import 'package:myAster/features/product/presentation/view_model/product_state.dart';

part 'product_event.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // final CreateProductUseCase _createProductUseCase;
  final GetAllProductsUseCase _getAllProductsUseCase;
  // final DeleteProductUseCase _deleteProductUseCase;
  // final UpdateProductUseCase _updateProductUseCase;

  ProductBloc({
    // required CreateProductUseCase createProductUseCase,
    required GetAllProductsUseCase getAllProductsUseCase,
    // required DeleteProductUseCase deleteProductUseCase,
    // required UpdateProductUseCase updateProductUseCase,
  })  :
        // _createProductUseCase = createProductUseCase,
        _getAllProductsUseCase = getAllProductsUseCase,
        // _deleteProductUseCase = deleteProductUseCase,
        // _updateProductUseCase = updateProductUseCase,
        super(ProductState.initial()) {
    on<LoadProducts>(_onLoadProducts);
    // on<AddProduct>(_onAddProduct);
    // on<DeleteProduct>(_onDeleteProduct);
    // on<UpdateProduct>(_onUpdateProduct);

    // Need to comment before running the Bloc Test
    // Trigger initial loading
    add(LoadProducts());
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllProductsUseCase.call();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) => emit(state.copyWith(
        isLoading: false,
        error: null,
        categories: categories,
      )),
    );
  }

  // Future<void> _onAddProduct(AddProduct event, Emitter<ProductState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _createProductUseCase.call(
  //     CreateProductParams(
  //         name: event.name,
  //         description: event.description,
  //         photo: state.imageName),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadProducts()),
  //   );
  // }

  // Future<void> _onDeleteProduct(
  //     DeleteProduct event, Emitter<ProductState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _deleteProductUseCase.call(
  //     DeleteProductParams(id: event.id),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadProducts()),
  //   );
  // }

  // Future<void> _onUpdateProduct(
  //     UpdateProduct event, Emitter<ProductState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _updateProductUseCase.call(
  //     UpdateProductParams(
  //         name: event.name, description: event.description, photo: event.photo),
  //   );
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) => add(LoadProducts()), // Reload categories after editing
  //   );
  // }
}
