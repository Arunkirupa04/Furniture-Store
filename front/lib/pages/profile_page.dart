import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/components/Profile/profile_tab.dart';
import 'package:food_delivery_app/pages/login_page.dart'; // Import LoginPage
import 'package:food_delivery_app/pages/settings_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    // Remove token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');

    // Navigate to LoginPage
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(
          onTap: () {},
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('/images/user.jpg'),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Justin Stone',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'justin2002@gmail.com',
            style: TextStyle(
              fontSize: 16.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(height: 24.0),
          Flexible(
            child: ListView(
              children: [
                ProfileTab(
                  icon: Icons.person_2_outlined,
                  title: 'Profile',
                  onTap: () {
                    print('Profile tapped');
                  },
                ),
                ProfileTab(
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  onTap: () {
                    print('Payment Methods tapped');
                  },
                ),
                ProfileTab(
                  icon: Icons.history_outlined,
                  title: 'Order History',
                  onTap: () {
                    print('Order History tapped');
                  },
                ),
                ProfileTab(
                  icon: Icons.location_on_outlined,
                  title: 'Delivery Address',
                  onTap: () {
                    print('Delivery Address tapped');
                  },
                ),
                ProfileTab(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ), // Added spacing between the Flexible ListView and the logout button
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: TextButton(
              onPressed: () => _logout(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
