import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleProductView extends StatefulWidget {
  final String productId;
  final String productName;
  final double price;
  final String image;
  final String description;
  final String genericName;
  final String manufacturer;

  const SingleProductView({
    super.key,
    required this.productId,
    required this.productName,
    required this.price,
    required this.image,
    required this.description,
    required this.genericName,
    required this.manufacturer,
  });

  @override
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  bool _isAddedToCart = false; // ✅ Track if product is added
  String? userId; // ✅ Store userId

  @override
  void initState() {
    super.initState();
    _loadUserId(); // Fetch userId when screen loads
  }

  // ✅ Fetch user ID from SharedPreferences
  Future<void> _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');

    if (id != null && id.isNotEmpty) {
      setState(() {
        userId = id;
      });
    } else {
      setState(() {
        userId = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User ID not found. Please login again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ✅ Function to Add Product to Cart
  Future<void> _addToCart() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User not logged in."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.88:5003/cart/add"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": userId,
          "productId": widget.productId,
          "quantity": 1, // Default quantity = 1
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        setState(() {
          _isAddedToCart = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData["message"] ?? "Product added to cart!"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception(responseData["message"] ?? "Failed to add product");
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
      backgroundColor: Colors.grey[200], // ✅ Soft background color
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Product Image with Shadow & Border
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.image,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    "https://via.placeholder.com/250",
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Product Name
            Text(
              widget.productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),

            // ✅ Price
            Text(
              "Price: NPR ${widget.price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 15),

            // ✅ Product Details Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("Generic Name", widget.genericName),
                    _buildDetailRow("Manufacturer", widget.manufacturer),
                    const Divider(),
                    _buildDetailRow("Description", widget.description),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Add to Cart Button
            Center(
              child: ElevatedButton.icon(
                onPressed: _isAddedToCart
                    ? null
                    : _addToCart, // Disable if already added
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor:
                      _isAddedToCart ? Colors.grey : Colors.blueAccent,
                  foregroundColor:
                      Colors.white, // ✅ Ensures text & icon are white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add_shopping_cart, size: 24),
                label: Text(
                  _isAddedToCart ? "Added to Cart" : "Add to Cart",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Helper Function for Displaying Details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black87),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
