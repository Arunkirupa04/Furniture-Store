import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/product_detail_page/wishlist_btn.dart';
import 'package:food_delivery_app/components/product_detail_page/product_actions.dart';
import 'package:food_delivery_app/services/api_services.dart';

class ProductDetailPage extends StatefulWidget {
  final String productName;
  final String company;
  final String price;
  final String imageUrl;
  final String productId; // Add productId to the constructor

  ProductDetailPage({
    required this.productName,
    required this.company,
    required this.price,
    required this.imageUrl,
    required this.productId, // Add productId to the constructor
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  late double productPrice;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    productPrice = double.parse(widget.price.replaceAll('\$', ''));
    totalPrice = quantity * productPrice;
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      totalPrice = quantity * productPrice;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        totalPrice = quantity * productPrice;
      });
    }
  }

  void addToCart() async {
    try {
      await ApiService().addToCartAPI(widget.productId, quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added to cart successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 0),
            child: WishlistButton(
              productId: widget.productId,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Image section
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text(
                              'Image not available',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                // Product details section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              widget.productName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            flex: 2,
                            child: Text(
                              widget.price,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: Theme.of(context).colorScheme.primary,
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Transform your living space with the Ox Mathis Furniture Modern Style collection. This exquisite piece combines contemporary design with unparalleled craftsmanship, making it a perfect addition to any home.\n\nFeatures:\n- Sleek Design: The minimalist aesthetic with clean lines and a sophisticated silhouette enhances the elegance of your room.\n- Premium Materials: Crafted from high-quality, durable materials to ensure longevity and resilience.\n- Comfort: Ergonomically designed for optimal comfort, providing the perfect balance between style and relaxation.\n- Versatility: Available in a variety of colors and finishes to match any decor and personal preference.\n- Easy Maintenance: Designed for easy cleaning and maintenance, allowing you to enjoy its beauty with minimal effort.\n\nDimensions:\n- Length: 200 cm\n- Width: 85 cm\n- Height: 75 cm\n\nWhy Choose Ox Mathis Furniture:\n- Exceptional Quality: Each piece is meticulously constructed to meet the highest standards.\n- Stylish Addition: Whether youre furnishing a new home or updating your current decor, the modern style seamlessly blends with any setting.\n- Sustainability: Our commitment to sustainability ensures that we use eco-friendly materials and processes.\n\nExperience the perfect fusion of style, comfort, and durability with the Ox Mathis Furniture Modern Style collection. Elevate your living space and create an inviting atmosphere that reflects your sophisticated taste.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ProductActions(
              quantity: quantity,
              totalPrice: totalPrice,
              onAddToCart: addToCart,
              onIncrement: incrementQuantity,
              onDecrement: decrementQuantity,
            ),
          ),
        ],
      ),
    );
  }
}
