// pages/category_detail_page.dart

import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/Home/cat_product_card.dart';
import 'package:food_delivery_app/components/Home/product_card_two.dart';
import 'package:food_delivery_app/models/product.dart';
import 'package:food_delivery_app/services/api_services.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryName;

  const CategoryDetailPage({Key? key, required this.categoryName})
      : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  List<Product> products = [];
  bool isLoading = true;
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchProducts(widget.categoryName);
  }

  Future<void> fetchProducts(String category) async {
    try {
      final List<Product> products =
          await _apiService.fetchProductsByCategory(category);
      print(products);
      setState(() {
        this.products = products;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching products: $e');
      // Handle error as needed, e.g., show a SnackBar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final product = products[index];
                return CatProductCard(
                  id: product.id,
                  productName: product.name,
                  company: product.brand,
                  price: product.price.toString(),
                  imageUrl: product
                      .images[0], // Assuming you want to use the first image
                );
              },
            ),
    );
  }
}
