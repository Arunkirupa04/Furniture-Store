import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/product_detail_page.dart';

class ProductCard2 extends StatelessWidget {
  final String id;
  final String productName;
  final String company;
  final String price;
  final String imageUrl;

  const ProductCard2({
    Key? key,
    required this.id,
    required this.productName,
    required this.company,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productId: id,
              productName: productName,
              company: company,
              price: price,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        height: 300,
        width: 200,
        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Text(
                    company,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        color: Theme.of(context).colorScheme.onSurface,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
