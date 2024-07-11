import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  final TabController tabController;

  MyTabBar({required this.tabController});

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: Colors.black.withOpacity(0.1),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 6.0, 0, 6.0),
            height: 90, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: TabBar(
              controller: widget.tabController,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.secondary,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: [
                _buildTab(Icons.home_rounded, Icons.home, 'Home'),
                _buildTab(
                    Icons.favorite_border_outlined, Icons.favorite, 'Favorite'),
                SizedBox(width: 40), // Add a spacer here
                _buildTab(
                    Icons.shopping_cart_rounded, Icons.shopping_cart, 'Cart'),
                _buildTab(Icons.person_2_rounded, Icons.person, 'Profile'),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.5),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(Icons.search_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
      IconData unselectedIcon, IconData selectedIcon, String label) {
    return Container(
      width: 100, // Set the minimum width here
      child: Tab(
        icon: Stack(
          children: [
            Icon(
              unselectedIcon,
              size: 24,
            ),
            Icon(
              selectedIcon,
              size: 24,
            ),
          ],
        ),
        text: label,
      ),
    );
  }
}
