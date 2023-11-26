import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/views/cart_view.dart';
import '../../categories/categories/views/categories_view.dart';
import '../../home_page/home_screen/views/home_screen_view.dart';
import '../../profile/setting/views/setting_view.dart';

class MainTabController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  final RxList<Widget> pages = [
    const HomeScreenView(),
    const CategoriesView(),
    const CartView(),
    const SettingView(),
  ].obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void onItemSelected(int value) {
    currentIndex.value = value;
    pageController.jumpToPage(value);
  }

  @override
  void onInit() {
    pageController.addListener(() {
      currentIndex.value = pageController.page!.round();
    });
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
