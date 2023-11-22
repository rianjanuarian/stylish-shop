import 'package:client/models/products.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {

  var isLoading = true.obs;
  var productName = <Products>[].obs;
  Future<void> searchProducts(String name) async{
    String url = "https://stylish-shop.vercel.app/products/search?name=$name";
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
     final List<dynamic> data = response.data;
        productName.value = data.map((item) => Products.fromJson(item)).toList();
        isLoading.value=false;
        print(data);
        update();
      } else {
         Get.snackbar(
          'Error Fetching Product by ID',
          'Error: ${response.statusCode.toString()}',
        );
      }
    } catch (e) {
      print(e);
    }
  }

}
