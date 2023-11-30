import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../services/api_service/product/product_model.dart';

class SearchPageController extends GetxController {
  var isLoading = true.obs;
  var productName = <Product>[].obs;
  Future<void> searchProducts(String name) async {
    String url = "https://stylish-shop.vercel.app/products/search?name=$name";
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        productName.value = data.map((item) => Product.fromJson(item)).toList();
        isLoading.value = false;
        update();
      } else {
        Get.snackbar(
          'Error Fetching Product by ID',
          'Error: ${response.statusCode.toString()}',
        );
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          final errorMessage = errorResponse.data?['message'];
          Get.snackbar('Error', errorMessage ?? 'Unknown error');
        } else {
          Get.snackbar('Error', 'Unknown error occurred');
        }
      } else {
        Get.snackbar('Error', e.toString());
      }
    }
  }
}
