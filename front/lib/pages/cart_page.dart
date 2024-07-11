import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/Cart/cart_card.dart';
import 'package:food_delivery_app/components/Cart/cart_actions.dart';
import 'package:food_delivery_app/services/api_services.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cartItems = [];
  bool isLoading = true;

  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final items = await _apiService.fetchCartItems();
      print(items);
      setState(() {
        cartItems = items;
        isLoading = false;
      });
      print("Fetched cart items: $cartItems");
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching cart items: $e');
      // Handle error as needed, e.g., show a SnackBar
    }
  }

  void deleteAllItems() {
    print('Deleting all items');
    // Implement delete logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        title: Text(
          'Cart',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
              ),
              child: IconButton(
                icon: Icon(Icons.delete_outline_rounded),
                onPressed: deleteAllItems,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? Center(child: Text('No items in cart'))
              : Stack(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(
                          bottom:
                              100), // Ensure padding to make space for the fixed button
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CartItemCard(
                          imageUrl: item['imageUrl'],
                          productName: item['productName'],
                          companyName: item['brand'],
                          price: item['price'],
                          quantity: item['quantity'],
                          onIncrease: () {
                            print('Increase quantity');
                          },
                          onDecrease: () {
                            print('Decrease quantity');
                          },
                          onRemove: () {
                            print('Remove item');
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CartActions(
                        subTotal: 29.99, // Example subtotal
                        shipping: 5.00, // Example shipping
                        totalPayment: 34.99, // Example total payment
                        onCheckout: () {
                          print('CheckEdout');
                          // Add your checkout logic here
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
