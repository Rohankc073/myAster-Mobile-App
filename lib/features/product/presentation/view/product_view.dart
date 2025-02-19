import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myasteer/features/product/presentation/view_model/product_bloc.dart';
import 'package:myasteer/features/product/presentation/view_model/product_state.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products List')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state.products.isEmpty) {
            return const Center(child: Text('No Products Available'));
          }
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];

              return ListTile(
                title: Text(product.name),
                // subtitle: Text(product.contact ?? 'No contact info'),
                leading: const Icon(Icons.person),
              );
            },
          );
        },
      ),
    );
  }
}
