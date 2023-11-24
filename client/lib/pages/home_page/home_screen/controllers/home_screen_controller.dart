import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../../../models/products.dart';
import '../../new_arrival/views/new_arrival_view.dart';

class HomeScreenController extends GetxController {
  var productList = <Products>[].obs;
  var productId = <Products>[].obs;
  var trendingList = <Products>[].obs;
  // Dummy
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
      trendingList.shuffle();
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

  void goToSearch() {
    Get.toNamed(AppPages.search);
  }

  void goToNewArrival() {
    Get.to(NewArrivalView("New Arrival"));
  }

  void goToTrendingProduct() {
    Get.to(NewArrivalView("Trending Products"));
  }


  void goToDetail(Products product) {
    Get.toNamed(AppPages.detail, arguments: product);
  }

  @override
  void onInit() async {
    getProducts();
    super.onInit();
  }
}
