import 'package:client/pages/get_start/get_started_one_screen.dart';
import 'package:client/pages/get_start/get_started_two_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: const [GetStartedOneScreen(), GetStartedTwoScreen()],
        ),
        Positioned(
            bottom: 30,
            left: 30,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const WormEffect(activeDotColor: Colors.black),
            ))
      ],
    );
  }
}
