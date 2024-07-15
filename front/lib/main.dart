import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/auth/login_or_register.dart';
import 'package:food_delivery_app/blocs/product_bloc.dart';
import 'package:food_delivery_app/blocs/product_event.dart';
import 'package:food_delivery_app/blocs/user_bloc.dart';
import 'package:food_delivery_app/pages/ar_screen.dart';
import 'package:food_delivery_app/pages/intro_page1.dart';
import 'package:food_delivery_app/pages/intro_page2.dart';
import 'package:food_delivery_app/pages/permission_req.dart';
import 'package:food_delivery_app/repositories/product_repository.dart';
import 'package:food_delivery_app/repositories/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/themes/theme_provider.dart';
import 'package:food_delivery_app/services/api_services.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    final UserRepository userRepository =
        UserRepository(apiService: apiService);
    final ProductRepository productRepository = ProductRepository();

    var themeProvider = Provider.of<ThemeProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsBloc>(
          create: (context) =>
              ProductsBloc(productRepository)..add(FetchProducts()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository: userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Food Delivery App',
        theme: themeProvider.themeData,
        debugShowCheckedModeBanner: false,
        // home: IntroPageHandler(),
        home: PermissionRequestPage(),
        routes: {
          '/login_or_register': (context) => LoginOrRegister(),
          '/intro_page2': (context) => IntroPage2(),
        },
      ),
    );
  }
}

class IntroPageHandler extends StatefulWidget {
  const IntroPageHandler({Key? key}) : super(key: key);

  @override
  _IntroPageHandlerState createState() => _IntroPageHandlerState();
}

class _IntroPageHandlerState extends State<IntroPageHandler> {
  @override
  void initState() {
    super.initState();
    // Navigate to second intro page after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroPage2()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntroPage1();
  }
}
