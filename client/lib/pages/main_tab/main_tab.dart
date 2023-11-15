import 'package:client/pages/categories/categories.dart';
import 'package:client/pages/home_page/home_screen.dart';
import 'package:client/pages/profile/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/bottom_navy_bar.dart';

class MainTab extends StatefulWidget {
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const HomeScreen(),
    const CategoriesPage(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: Colors.white70,
        containerHeight: 65.h,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 10,
        curve: Curves.easeIn,
        onItemSelected: (value) {
          setState(() => _currentIndex = value);
          _pageController.jumpToPage(value);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.shopping_bag),
            title: const Text('Cart'),
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.category),
            title: const Text('Categories'),
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
