import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String userId = "";
  List cartItems = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId') ?? '';

    if (id.isNotEmpty) {
      setState(() {
        userId = id;
      });
      _fetchCartData();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "User not found.";
      });
    }
  }

  Future<void> _fetchCartData() async {
    try {
      final response =
          await http.get(Uri.parse("http://localhost:5003/cart/$userId"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cartItems = data['items'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load cart");
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    }
  }

  Future<void> _removeItemFromCart(String productId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost:5003/cart/remove"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"userId": userId, "productId": productId}),
      );

      if (response.statusCode == 200) {
        setState(() {
          cartItems.removeWhere((item) => item['productId'] == productId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item removed from cart")),
        );
      } else {
        throw Exception("Failed to remove item");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  Future<void> _clearCart() async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost:5003/cart/clear/$userId"),
      );

      if (response.statusCode == 200) {
        setState(() {
          cartItems.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cart cleared successfully")),
        );
      } else {
        throw Exception("Failed to clear cart");
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)))
              : cartItems.isEmpty
                  ? const Center(
                      child: Text("Your cart is empty",
                          style: TextStyle(fontSize: 18)))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(12),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];

                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      item['image'],
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.network(
                                              "https://via.placeholder.com/150",
                                              width: 65,
                                              height: 65,
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                  title: Text(
                                    item['name'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Price: NPR ${item['price']} x ${item['quantity']}",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      _removeItemFromCart(item['productId']);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // ✅ Total Price and Clear Cart Button
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ],
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total:",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Text(
                                  //   "NPR ${cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']))}",
                                  //   style: const TextStyle(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.green),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _clearCart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 12),
                                ),
                                child: const Text(
                                  "Clear Cart",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }
}
