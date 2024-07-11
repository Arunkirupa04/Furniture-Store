import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  const MyTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabs: [
            Tab(text: "Home"),
            Tab(text: "Menu"),
            Tab(text: "Profile"),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Container(color: Colors.blue), // Replace with your content
              Container(color: Colors.red), // Replace with your content
              Container(color: Colors.green), // Replace with your content
            ],
          ),
        ),
      ],
    );
  }
}
