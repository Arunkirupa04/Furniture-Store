import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Delayed navigation to next page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/intro_page2');
    });

    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .primary, // Replace with your primary color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '/images/logo.png', // Adjust the path to your logo
              width: 150,
              height: 150,
            ),
            Text(
              "Cozy Creations",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            )
          ],
        ),
      ),
    );
  }
}
