import 'package:client/models/products.dart';
import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class NewArrivalController extends GetxController {
  RxBool isLoading = RxBool(false);
  var productList = <Products>[].obs;
  final dio = Dio();

  Future<void> getProduct() async {
    try {
      isLoading.toggle();
      String url = 'https://stylish-shop.vercel.app/products';
      final response = await dio.get(url);
      final List<dynamic> result = response.data;
      productList.value = result.map((e) => Products.fromJson(e)).toList();
      isLoading.toggle();
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
      isLoading.toggle();
    }
  }

  void goToDetail(Products product) {
    Get.toNamed(AppPages.detail, arguments: product);
  }
}
