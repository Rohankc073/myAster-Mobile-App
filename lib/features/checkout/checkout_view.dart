import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutPage extends StatefulWidget {
  final List cartItems; // ✅ Accept cart items from cart page

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String userId = "";
  String shippingAddress = "";
  String paymentMethod = "COD";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId') ?? '';
    });
  }

  Future<void> _placeOrder() async {
    if (shippingAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your shipping address")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.88:5003/order/add"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "shippingAddress": shippingAddress,
          "paymentMethod": paymentMethod,
          "items": widget.cartItems
              .map((item) => {
                    "productId": item['productId'],
                    "name": item['name'],
                    "quantity": item['quantity'],
                    "price": item['price'],
                    "image": item['image'],
                  })
              .toList(),
          "total": widget.cartItems.fold<double>(
              0.0,
              (sum, item) =>
                  sum +
                  ((item['price'] as num) * (item['quantity'] as int))
                      .toDouble()),
        }),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Order placed successfully!")),
        );
        Navigator.pop(context);
      } else {
        throw Exception("Failed to place order");
      }
    } catch (error) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${error.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.fold<double>(
      0.0,
      (sum, item) =>
          sum + ((item['price'] as num) * (item['quantity'] as int)).toDouble(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Shipping Address",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextField(
                    decoration:
                        const InputDecoration(hintText: "Enter your address"),
                    onChanged: (value) => setState(() {
                      shippingAddress = value;
                    }),
                  ),
                  const SizedBox(height: 20),
                  const Text("Payment Method",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value!;
                      });
                    },
                    items: ["COD", "Credit Card", "Debit Card", "UPI"]
                        .map((method) => DropdownMenuItem(
                            value: method, child: Text(method)))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text("Order Summary",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        return ListTile(
                          leading: Image.network(item['image'],
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item['name']),
                          subtitle: Text(
                              "Quantity: ${item['quantity']} - NPR ${item['price'] * item['quantity']}"),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Total: NPR ${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _placeOrder,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.all(14)),
                      child: const Text("Place Order",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
