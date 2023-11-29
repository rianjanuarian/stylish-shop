import 'package:stylish_shop/pages/get_start/get_started_one_screen.dart';
import 'package:stylish_shop/pages/get_start/get_started_two_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  bool isFirstPage = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const GetStartedOneScreen(),
    const GetStartedTwoScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: _pages,
        ),
        Positioned(
          bottom: 0.05.sh,
          left: 0.05.sw,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: 2,
            effect: const WormEffect(activeDotColor: Colors.black),
          ),
        )
      ],
    );
  }
}
