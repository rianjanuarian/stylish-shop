import 'package:client/pages/main_tab/controllers/main_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/bottom_navy_bar.dart';

class MainTab extends GetView<MainTabController> {
  const MainTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.onPageChanged(index);
          },
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          backgroundColor: Colors.white70,
          containerHeight: 65.h,
          selectedIndex: controller.currentIndex.value,
          showElevation: true,
          itemCornerRadius: 10.r,
          curve: Curves.easeIn,
          onItemSelected: controller.onItemSelected,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
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
              icon: const Icon(Icons.shopping_bag),
              title: const Text('Cart'),
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
      ),
    );
  }
}
