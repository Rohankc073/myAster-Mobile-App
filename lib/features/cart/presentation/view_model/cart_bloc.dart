import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myAster/features/cart/domain/entity/cart_item_entity.dart';
import 'package:myAster/features/cart/domain/use_case/add_product_usecase.dart';
import 'package:myAster/features/cart/domain/use_case/clear_cart_usecase.dart';
import 'package:myAster/features/cart/domain/use_case/get_cart_usecase.dart';
import 'package:myAster/features/cart/domain/use_case/remove_product_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddProductUsecase addProductUsecase;
  final RemoveProductUsecase removeProductUsecase;
  final ClearCartUsecase clearCartUsecase;
  final GetCartUsecase getCartUsecase;

  CartBloc({
    required this.addProductUsecase,
    required this.removeProductUsecase,
    required this.clearCartUsecase,
    required this.getCartUsecase,
  }) : super(CartState.initial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddProductToCartEvent>(_onAddProduct);
    on<RemoveProductFromCartEvent>(_onRemoveProduct);
    on<ClearCartEvent>(_onClearCart);
  }

  // ✅ Load Cart Data
  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await getCartUsecase.call(GetCartParams(userId: event.userId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (cartItems) {
        emit(state.copyWith(isLoading: false, items: cartItems));
      },
    );
  }

  // ✅ Add Product to Cart
  Future<void> _onAddProduct(
      AddProductToCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await addProductUsecase.call(
      AddProductParams(
        productId: event.productId,
        userId: event.userId,
        name: event.name,
        price: event.price,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        // ✅ Reload cart after adding product
        add(LoadCartEvent(userId: event.userId));
      },
    );
  }

  // ✅ Remove Product from Cart
  Future<void> _onRemoveProduct(
      RemoveProductFromCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await removeProductUsecase.call(
      RemoveProductParams(
        productId: event.productId,
        userId: event.userId,
        name: event.name,
        price: event.price,
        quantity: event.quantity,
      ),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        // ✅ Reload cart after removing product
        add(LoadCartEvent(userId: event.userId));
      },
    );
  }

  // ✅ Clear Entire Cart
  Future<void> _onClearCart(
      ClearCartEvent event, Emitter<CartState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await clearCartUsecase.call(
      ClearCartParams(userId: event.userId),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false, items: []));
      },
    );
  }
}
