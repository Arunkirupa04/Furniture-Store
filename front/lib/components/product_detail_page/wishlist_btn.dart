import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/api_services.dart';

class WishlistButton extends StatelessWidget {
  final String productId;

  WishlistButton({
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    // Access the current color scheme
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(
          Icons.favorite_border,
          color: colorScheme.onBackground,
        ),
        onPressed: () async {
          try {
            await ApiService().addToWishlist(productId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Added to wishlist successfully!')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add to wishlist: $e')),
            );
          }
        },
      ),
    );
  }
}
