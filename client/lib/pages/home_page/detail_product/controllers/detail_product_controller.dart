import 'package:client/models/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../services/keys/get_storage_key.dart';

class DetailProductController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt price = 0.obs;
  Rx<Color> selectedColor = Colors.red.obs;
  int initialProductPrice = 200000;
  RxBool isLoading = RxBool(false);
  final dio = Dio();
  final storage = GetStorage();

  void addQuantity() {
    quantity++;
    changePrice();
  }

  void substractQuantity() {
    quantity--;
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
            "color": getColorFromString(selectedColor),
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

  String getColorFromString(Rx<Color> color) {
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

  @override
  void onInit() {
    super.onInit();
    final Products product = Get.arguments;
    setInitialPrice(product.price ?? 0);
  }
}
