import 'package:flutter/material.dart';

class SingleProductView extends StatelessWidget {
  final String productId;
  final String productName;
  final double price;
  final String image;

  const SingleProductView({
    super.key,
    required this.productId,
    required this.price,
    required this.productName,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ✅ Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.network(
                  "https://via.placeholder.com/250",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Product Name
            Text(
              productName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ✅ Price
            Text(
              "Price: NPR ${price.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Product ID
            Text(
              "Product ID: $productId",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Add to Cart Button
            ElevatedButton(
              onPressed: () {
                // Implement Add to Cart Functionality
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                "Add to Cart",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
