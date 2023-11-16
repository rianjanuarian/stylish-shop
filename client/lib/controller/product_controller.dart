import 'package:client/models/products.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = <Products>[].obs;
  var isLoading = true.obs;
  var productId = <Products>[].obs;
  RxInt counter = 0.obs;
  @override
  void onInit() {
    super.onInit();

    getProducts();
  }

  Future<void> getProducts() async {
    String url = 'https://stylish-shop.vercel.app/products';

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

  Future<void> getProductById(int id) async {
    //'http://192.168.0.104:3000/products'
    String url = 'https://stylish-shop.vercel.app/products/detail/$id';
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        productId.value = [Products.fromJson(data)];
        isLoading.value = false;
        print(data);
        update();
      } else {
        Get.snackbar(
          'Error Fetching Product by ID',
          'Error: ${response.statusCode.toString()}',
        );
      }
    } catch (e) {
      print('error : ${e}');
    }
  }

  void increment(int stock) {
    if (counter < stock) {
      counter++;
    }
  }

  void decrement() {
    if (counter > 0) {
      counter--;
    }
  }
}
