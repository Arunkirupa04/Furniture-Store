import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/product_bloc.dart';
import 'package:food_delivery_app/blocs/product_state.dart';
import 'package:food_delivery_app/blocs/product_event.dart';
import 'package:food_delivery_app/components/Home/cat_product_card.dart';
import 'package:food_delivery_app/components/Home/searchbar.dart';
import 'package:food_delivery_app/models/product.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBarComponent(),
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductsLoaded) {
                  // Calculate number of rows
                  int rowCount = (state.products.length / 2).ceil();

                  return ListView.builder(
                    itemCount: rowCount,
                    itemBuilder: (context, index) {
                      int startIndex = index * 2;
                      int endIndex = startIndex + 2;
                      if (endIndex > state.products.length) {
                        endIndex = state.products.length;
                      }

                      List<Product> products =
                          state.products.sublist(startIndex, endIndex);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: products.map((product) {
                          return Expanded(
                            child: CatProductCard(
                              id: product.id,
                              productName: product.name,
                              company: product.brand,
                              price: '\$${product.price.toStringAsFixed(2)}',
                              imageUrl: product.images[0],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                } else if (state is ProductsError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('No products found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
