import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/Home/categories_page_card.dart';
import 'package:food_delivery_app/components/Home/product_card_two.dart';
import 'package:food_delivery_app/pages/category_detail_page.dart';
import 'package:food_delivery_app/services/api_services.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<Map<String, String>> categories = [
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Belino-Wing-Chair_360x.jpg?v=1675672850',
      'categoryName': 'Living Room Furniture',
    },
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Celeste_800x800.jpg?v=1675674044',
      'categoryName': 'Bedroom Furniture',
    },
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Belino-Wing-Chair_360x.jpg?v=1675672850',
      'categoryName': 'Dining Room Furniture',
    },
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Celeste_800x800.jpg?v=1675674044',
      'categoryName': 'Home Décor',
    },
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Belino-Wing-Chair_360x.jpg?v=1675672850',
      'categoryName': 'Office Furniture',
    },
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Celeste_800x800.jpg?v=1675674044',
      'categoryName': 'Kitchen Furniture',
    },
    {
      'imageUrl':
          'https://finez.lk/cdn/shop/products/Celeste_800x800.jpg?v=1675674044',
      'categoryName': 'Storage Furniture',
    },
    // Add more categories as needed
  ];

  ApiService _apiService = ApiService();
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts(categories[0]
        ['categoryName']!); // Fetch products for the first category initially
  }

  Future<void> fetchProducts(String category) async {
    try {
      final List<dynamic> products =
          await _apiService.fetchProductsByCategory(category);
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
        title: Text('Categories'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryCard(
                    imageUrl: category['imageUrl']!,
                    categoryName: category['categoryName']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryDetailPage(
                            categoryName: category['categoryName']!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
