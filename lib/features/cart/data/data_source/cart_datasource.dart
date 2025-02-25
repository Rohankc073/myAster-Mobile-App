import 'package:dio/dio.dart';
import 'package:myasteer/app/constants/api_endpoints.dart';
import 'package:myasteer/app/shared_prefs/user_shared_prefs.dart';
import 'package:myasteer/features/cart/domain/entity/cart_item_entity.dart';

class CartDatasource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  CartDatasource({required Dio dio, required UserSharedPrefs userSharedPrefs})
      : _dio = dio,
        _userSharedPrefs = userSharedPrefs;

  Future<String> sharedPrefUserId() async {
    final userId = await _userSharedPrefs.getUserData();
    return userId.fold(
      (l) => throw Exception(l),
      (r) => "$r",
    );
  }

  Future<void> addProductToCart(
    CartItemEntity product,
  ) async {
    try {
      final userId = await sharedPrefUserId();
      final response = await _dio.post(ApiEndpoints.addProductToCart, data: {
        "userId": userId,
        "productId": product.productId,
        // "quantity": product.quantity
      });
      if (response.statusCode == 200) {
        print("Product added to cart successfully");

        return;
      } else {
        print("Failed to add product to cart: ${response.statusCode}");
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<void> removeProductFromCart(
  //   CartItemEntity product,
  // ) async {
  //   try {
  //     final userId = await sharedPrefUserId();
  //     final response =
  //         await _dio.post(ApiEndpoints.removeProductFromCart, data: {
  //       "userId": userId,
  //       "productId": product.productId,
  //       // "quantity": product.quantity
  //     });
  //     if (response.statusCode == 200) {
  //       print("Product removed from cart successfully");

  //       return;
  //     } else {
  //       print("Failed to remove product from cart: ${response.statusCode}");
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<void> clearCart() async {
  //   try {
  //     final userId = await sharedPrefUserId();
  //     final response = await _dio.post(ApiEndpoints.clearCart, data: {
  //       "userId": userId,
  //       // "productId": product.productId,
  //       // "quantity": product.quantity
  //     });
  //     if (response.statusCode == 200) {
  //       print("Product added to cart successfully");

  //       return;
  //     } else {
  //       print("Failed to add product to cart: ${response.statusCode}");
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  // Future<List<CartItemEntity>> getCartProducts() async {
  //   try {
  //     final userId = await sharedPrefUserId();
  //     final response = await _dio.get("${ApiEndpoints.cart}/$userId");
  //     if (response.statusCode == 200) {
  //       print("Product added to cart successfully");
  //       final List<dynamic> cartItemModelList = response.data['cart'];
  //       final data = cartItemModelList
  //           .map((e) => CartItemApiModel.fromJson(e as Map<String, dynamic>));
  //       return data.map((e) => e.toEntity()).toList();
  //     } else {
  //       print("Failed to add product to cart: ${response.statusCode}");
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
