

import 'package:client/config.dart';
import 'package:client/models/products.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';


class ProductController extends GetxController {
  var productList = <Products>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    getProducts();
  }

  Future<void> getProducts() async {
    //'http://192.168.0.104:3000/products'
    String url = Config.productsAPI ;
    try {
      final response = await Dio().get(
        url,
      );

      if (response.statusCode == 200) {
        final List<dynamic> result = response.data;
        print(result);
        productList.value = result.map((e) => Products.fromJson(e)).toList();
        isLoading.value = false;

        update();
      } else {
        Get.snackbar(
            'error fetching data', 'error : ${response.statusCode.toString()}');
      }
    } catch (e) {
      print(e);
    }
  }
}
