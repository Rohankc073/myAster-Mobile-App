import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/cart/presentation/view_model/cart_bloc.dart';

class CartScreenView extends StatelessWidget {
  const CartScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulating fetching data from the database
    final List<Map<String, dynamic>> cartItems = [
      {
        'image': 'assets/images/smirnoff.png', // Replace with local asset
        'name': 'Smirnoff Lemon Vodka',
        'description': 'A refreshing lemon-flavored vodka.',
        'price': 2.98,
        'quantity': 1,
      },
      {
        'image': 'assets/images/smirnoff.png',
        'name': 'Jack Daniel’s Cola Whiskey',
        'description': 'Smooth cola-infused whiskey blend.',
        'price': 3.98,
        'quantity': 1,
      },
      {
        'image': 'assets/images/smirnoff.png',
        'name': 'Calsberg Premium Beer',
        'description': 'Crisp, premium quality beer.',
        'price': 3.50,
        'quantity': 1,
      }
    ];

    // Calculate total price dynamically
    // double calculateTotalPrice(List<CartItemEntity> items) {
    //   return items.fold(
    //       0.0, (total, item) => total + item.price * item.quantity);
    // }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text("Error: ${state.error}"));
            }
            if (state.items.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            }

            // double totalPrice = calculateTotalPrice(state.items);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Image.network(
                                item.productImage, // Using a local asset
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                // Prevents overflow
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      item.productDescription,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        // IconButton(
                                        //   icon: const Icon(Icons.remove),
                                        //   onPressed: () {
                                        //     context
                                        //         .read<CartBloc>()
                                        //         .add(RemoveProductFromCartEvent(
                                        //           productId: item.productId,
                                        //           userId: "rohan",
                                        //           productName: item.productName,
                                        //           productPrice: item.price,
                                        //           // productQuantity:
                                        //           //     item.quantity
                                        //         ));
                                        //   },
                                        // ),
                                        // const Text(
                                        //   item.quantity.toString(),
                                        //   style: TextStyle(fontSize: 16),
                                        // ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            context
                                                .read<CartBloc>()
                                                .add(AddProductToCartEvent(
                                                  productId: item.productId,
                                                  userId: "rohan",
                                                  productName: item.productName,
                                                  productPrice: item.price,
                                                  context: context,
                                                  // productQuantity:
                                                  //     item.quantity
                                                ));
                                          },
                                        ),
                                        const Spacer(),
                                        Text(
                                          '\$${item.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Total Price Section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Text(
                          //   '\$${totalPrice.toStringAsFixed(2)}',
                          //   style: const TextStyle(
                          //     fontSize: 18,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Implement Place Order action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Place Order',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
