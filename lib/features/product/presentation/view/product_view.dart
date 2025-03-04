import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myAster/features/product/presentation/view/single_product.dart';
import 'package:myAster/features/product/presentation/view_model/product_bloc.dart';
import 'package:myAster/features/product/presentation/view_model/product_state.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.trim().isEmpty) {
      return "https://via.placeholder.com/150"; // Fallback Image
    }
    if (imagePath.contains("localhost")) {
      return imagePath.replaceFirst("localhost", "127.0.0.1");
    }
    return imagePath.trim();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.error != null) {
          return Center(
            child: Text(
              'Error: ${state.error}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        }
        if (state.products.isEmpty) {
          return const Center(
            child: Text(
              'No Products Available',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleProductView(
                        productId: product.id ?? "",
                        productName: product.name ?? "Unknown Product",
                        price: product.price ?? 0.0,
                        image: getImageUrl(product.image),
                        description:
                            product.description ?? "No Description Available",
                        genericName: product.genericName ?? "Not Provided",
                        manufacturer:
                            product.manufacturer ?? "Unknown Manufacturer",
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ✅ Product Image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Image.network(
                            getImageUrl(product.image),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.network(
                              "https://via.placeholder.com/150",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),

                      // ✅ Product Name & Price
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.name ?? "Unknown Product",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "NPR ${product.price.toStringAsFixed(2) ?? "0.00"}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
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
        );
      },
    );
  }
}
