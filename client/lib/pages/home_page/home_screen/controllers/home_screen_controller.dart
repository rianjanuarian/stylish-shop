import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../../models/products.dart';

class HomeScreenController extends GetxController {
  var productList = <Products>[].obs;
  var productId = <Products>[].obs;
  var trendingList = <Products>[].obs;
  final List<Map<String, dynamic>> dummyCoupon = [
    {
      "percent": 50,
      "title": "On everything today",
      "code": "FSCREATION",
      "image": "assets/images/diskon1.png"
    },
    {
      "percent": 70,
      "title": "On shirt today",
      "code": "STYLECODE",
      "image": "assets/images/diskon2.png"
    },
  ];
  final dio = Dio();
  RxBool isLoading = RxBool(false);

  Future<void> getProducts() async {
    try {
      isLoading.toggle();
      String url = 'https://stylish-shop.vercel.app/products';
      final response = await dio.get(url);
      final List<dynamic> result = response.data;
      productList.value = result.map((e) => Products.fromJson(e)).toList();
      trendingList.value = result.map((e) => Products.fromJson(e)).toList();
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

  // Future<void> getProductById(int id) async {
  //   //'http://192.168.0.104:3000/products'
  //   String url = 'https://stylish-shop.vercel.app/products/detail/$id';
  //   try {
  //     final response = await dio.get(url);

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = response.data;
  //       productId.value = [Products.fromJson(data)];
  //       isLoading.value = false;
  //       print(data);
  //       update();
  //     } else {
  //       Get.snackbar(
  //         'Error Fetching Product by ID',
  //         'Error: ${response.statusCode.toString()}',
  //       );
  //     }
  //   } catch (e) {
  //     print('error : $e');
  //   }
  // }

  void goToSearch() {
    Get.toNamed(AppPages.search);
  }

  void goToNewArrival() {
    Get.toNamed(AppPages.newArrival);
  }

  void goToDetail(Products product) {
    Get.toNamed(AppPages.detail, arguments: product);
  }

  void trendingProducts() {
    trendingList.shuffle();
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
