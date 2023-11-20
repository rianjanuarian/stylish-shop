import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  //dummy cart product
  final List<Map> dummyCarts = [
    {
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Roller Rabbit',
      'description': 'Vado Odelle Dress',
      'price': 198,
      'quantity': 1,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Axel Arigato',
      'description': 'Clean 90 Triole Snakers',
      'price': 245,
      'quantity': 1,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Herschel Supply Co.',
      'description': 'Daypack Backpack',
      'price': 40,
      'quantity': 1,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Roller Rabbah',
      'description': 'Nasi Goreng Lemak',
      'price': 40,
      'quantity': 2,
    },
    {
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Roller Rabbah',
      'description': 'Nasi Goreng Lemak',
      'price': 40,
      'quantity': 2,
    },
  ].obs;

  RxBool isLoading = RxBool(false);

  void getCart() {
    try {
      isLoading.toggle();
      //fetch carts from api
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          final errorMessage = errorResponse.data?['message'];
          Get.snackbar('Error', errorMessage ?? 'Unknown error');
        } else {
          Get.snackbar('Error', 'Unknown error occurred');
        }
        isLoading.toggle();
      }
    }
  }

  void goToSearch() {
    Get.toNamed(AppPages.search);
  }

  @override
  void onInit() {
    getCart();
    super.onInit();
  }
}
