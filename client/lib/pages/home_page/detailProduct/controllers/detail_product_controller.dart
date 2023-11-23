import 'package:client/models/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  RxInt quantity = 1.obs;
  RxInt price = 0.obs;
  Rx<Color> selectedColor = Colors.red.obs;
  int initialProductPrice = 200000;

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

  @override
  void onInit() {
    super.onInit();
    final Products product = Get.arguments;
    setInitialPrice(product.price ?? 0);
  }
}
