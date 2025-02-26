// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myasteer/app/shared_prefs/user_shared_prefs.dart';
// import 'package:myasteer/features/cart/presentation/view_model/cart_bloc.dart';
// import 'package:myasteer/features/product/presentation/view_model/product_bloc.dart';
// import 'package:myasteer/features/product/presentation/view_model/product_state.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ProductDetailView extends StatelessWidget {
//   final String productId;

//   const ProductDetailView({super.key, required this.productId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProductBloc()
//         ..add(GetProductByIdEvent(productId)), // Fetch product details on load
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Product Details"),
//           backgroundColor: Colors.blueAccent,
//         ),
//         body: BlocBuilder<ProductBloc, ProductState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state.error != null) {
//               return Center(
//                 child: Text(
//                   "Error: ${state.error}",
//                   style: const TextStyle(color: Colors.red, fontSize: 16),
//                 ),
//               );
//             }

//             final product = state.selectedProduct;
//             if (product == null) {
//               return const Center(child: Text("Product not found"));
//             }

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Image.network(
//                       product['image'],
//                       width: 250,
//                       height: 250,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                           Image.network(
//                         "https://via.placeholder.com/150",
//                         width: 250,
//                         height: 250,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   Text(
//                     product['name'],
//                     style: const TextStyle(
//                         fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 5),

//                   Text(
//                     "Price: \$${product['price']}",
//                     style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green),
//                   ),
//                   const SizedBox(height: 10),

//                   Text(
//                     product['description'] ?? "No description available",
//                     style: const TextStyle(fontSize: 16, color: Colors.black54),
//                   ),
//                   const SizedBox(height: 20),

//                   // ✅ Add to Cart Button
//                   ElevatedButton(
//                     onPressed: () async {
//                       final sharedPreferences =
//                           await SharedPreferences.getInstance();
//                       final userResult =
//                           await UserSharedPrefs(sharedPreferences)
//                               .getUserData();
//                       final userId = userResult.fold(
//                         (failure) => '',
//                         (userData) => userData['userId'] ?? '',
//                       );

//                       // Add product to cart
//                       BlocProvider.of<CartBloc>(context).add(
//                         AddProductToCartEvent(
//                           productId: product['_id'],
//                           userId: userId,
//                           productName: product['name'],
//                           productPrice: (product['price'] as num).toDouble(),
//                         ),
//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content: Text("${product['name']} added to cart")),
//                       );
//                     },
//                     child: const Text("Add to Cart"),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
