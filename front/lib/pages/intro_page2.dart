import 'package:flutter/material.dart';

class IntroPage2 extends StatefulWidget {
  @override
  _IntroPage2State createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  final List<IntroModel> intros = [
    IntroModel(
      image: '/images/intro_img1.png',
      text: 'Transform your space with elegance and comfort',
    ),
    IntroModel(
      image: '/images/intro_img2.png',
      text: 'Discover modern furniture for your home',
    ),
    IntroModel(
      image: '/images/intro_img3.png',
      text: 'Shop with confidence, every time',
    ),
  ];

  PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < intros.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login_or_register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: intros.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return IntroPageItem(introModel: intros[index]);
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/login_or_register');
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _nextPage,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroPageItem extends StatelessWidget {
  final IntroModel introModel;

  const IntroPageItem({Key? key, required this.introModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 40),
        Stack(
          children: [
            Container(
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  introModel.image,
                  width: double.infinity,
                  // height: 100,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          introModel.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class IntroModel {
  final String image;
  final String text;

  IntroModel({required this.image, required this.text});
}
