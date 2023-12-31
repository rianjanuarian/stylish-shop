import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stylish_shop/routes/app_pages.dart';
import '../../../../services/api_service/product/product_model.dart';
import '../../../../services/keys/get_storage_key.dart';

class DetailProductController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt price = 0.obs;
  Rx<Color> selectedColor = Colors.red.obs;
  int initialProductPrice = 0;
  RxBool isLoading = RxBool(false);
  final dio = Dio();
  final storage = GetStorage();
  RxInt cartquantity = 0.obs;

  void addQuantity() {
    quantity++;
    changePrice();
  }

  void substractQuantity() {
    quantity--;
    changePrice();
  }

  void addCart() {
    cartquantity++;
    changePrice();
  }

  void changeColor(Color color) => selectedColor.value = color;

  void changePrice() {
    price.value = quantity.value * initialProductPrice;
  }

  void setInitialPrice(int initialPrice) {
    price.value = quantity.value * initialPrice;
    changePrice();
  }

  void addToCart(int productId) async {
    try {
      final token = await storage.read(GetStorageKey.token);
      final res = await dio.post('https://stylish-shop.vercel.app/carts/create',
          data: {
            "productId": productId,
            "color": getColorFromString(selectedColor.value),
            "qty": quantity.value,
            "total_price": price.value
          },
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      Get.snackbar('Success', res.data?['message']);
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

  String getColorFromString(Color color) {
    switch (color) {
      case Colors.red:
        return "red";
      case Colors.green:
        return 'green';
      case Colors.blue:
        return 'blue';
      case Colors.yellow:
        return 'yellow';
      default:
        return 'white';
    }
  }

  void goToCart() {
    Get.toNamed(AppPages.cart);
  }

  @override
  void onInit() {
    super.onInit();
    final Product product = Get.arguments;
    initialProductPrice = product.price ?? 0;
    setInitialPrice(product.price ?? 0);
  }
}
