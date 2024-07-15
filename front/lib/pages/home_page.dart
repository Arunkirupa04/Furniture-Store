import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/product_bloc.dart';
import 'package:food_delivery_app/blocs/product_state.dart';
import 'package:food_delivery_app/components/Home/category_card.dart';
import 'package:food_delivery_app/components/Home/product_card_one.dart';
import 'package:food_delivery_app/components/Home/product_card_two.dart';
import 'package:food_delivery_app/components/Home/searchbar.dart';
import 'package:food_delivery_app/components/Home/specialoffer_card.dart';
import 'package:food_delivery_app/components/Home/user_description_notification.dart';
import 'package:food_delivery_app/components/my_tab_bar.dart';
import 'package:food_delivery_app/pages/categories_page.dart';
import 'package:food_delivery_app/pages/category_detail_page.dart';
import 'package:food_delivery_app/pages/favorite_page.dart';
import 'package:food_delivery_app/pages/profile_page.dart';
import 'package:food_delivery_app/pages/cart_page.dart';
import 'package:food_delivery_app/pages/search_products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   title: Text(
      //     'Home',
      //     style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
      //   ),
      //   elevation: 0,
      // ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDescriptionAndNotification(
                    userName: 'Justin Stone',
                    profileImage: 'assets/images/user.jpg',
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.4),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search Product",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SpecialOfferCard(
                          discountDetail: '25% Discount',
                          detail: 'For cosy Yellow Cushion',
                          imageUrl: 'assets/images/special_offer.png',
                        ),
                        SizedBox(width: 8.0),
                        SpecialOfferCard(
                          discountDetail: '30% Discount',
                          detail: 'For elegant Blue Armchair',
                          imageUrl: 'assets/images/special_offer.png',
                        ),
                        SizedBox(width: 8.0),
                        SpecialOfferCard(
                          discountDetail: '20% Discount',
                          detail: 'For comfortable Green Sofa',
                          imageUrl: 'assets/images/special_offer.png',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesPage(),
                              ),
                            );
                          },
                          child: Text("SeeAll"))
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoriesCard(
                          icon: Icons.bed,
                          name: 'Bedroom',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(
                                    categoryName: 'Bedroom Furniture'),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 8.0),
                        CategoriesCard(
                          icon: Icons.chair,
                          name: 'Living',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(
                                    categoryName: 'Living Furniture'),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 8.0),
                        CategoriesCard(
                          icon: Icons.kitchen,
                          name: 'Kitchen',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(
                                    categoryName: 'Kitchen Furniture'),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 8.0),
                        CategoriesCard(
                          icon: Icons.kitchen,
                          name: 'Office',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(
                                    categoryName: 'Office Furniture'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Most Interested",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ProductsLoaded) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.products.map((product) {
                              return ProductCard2(
                                id: product.id,
                                productName: product.name,
                                company: product.brand,
                                price: '\$${product.price.toStringAsFixed(2)}',
                                imageUrl: product.images[0],
                              );
                            }).toList(),
                          ),
                        );
                      } else if (state is ProductsError) {
                        return Center(child: Text(state.message));
                      } else {
                        return Center(child: Text('Unknown state'));
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "Popular",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ProductCard1(
                          productName: 'Modern Table',
                          company: 'Furniture Co.',
                          price: '\$250',
                          imageUrl: 'assets/images/chair_green (1).png',
                          id: '123s',
                        ),
                        ProductCard1(
                          productName: 'Modern Table',
                          company: 'Furniture Co.',
                          price: '\$250',
                          imageUrl: 'assets/images/chair_green (2).png',
                          id: '123s',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          FavoritesPage(),
          Center(child: Text('Nothing Tab')),
          CartPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.surface,
        child: MyTabBar(tabController: _tabController),
      ),
    );
  }
}
