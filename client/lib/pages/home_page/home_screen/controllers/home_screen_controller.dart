import 'package:client/routes/app_pages.dart';
import 'package:client/services/api_service/product/product_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  var productList = <Product>[].obs;
  var productId = <Product>[].obs;
  var trendingList = <Product>[].obs;
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
      //bikin logic klo barang kosong g muncul
      productList.value = result.map((e) => Product.fromJson(e)).toList().where((product) => product.stock != 0).toList();
      trendingList.value = result.map((e) => Product.fromJson(e)).toList().where((product) => product.stock != 0).toList();
      trendingList.shuffle();
      isLoading.toggle();
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          if (errorResponse.data is Map) {
            final errorMessage = errorResponse.data['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', e.toString());
          }
        } else {
          Get.snackbar('Error', e.toString());
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
    Get.toNamed(AppPages.newArrival, arguments: 'New Arrival');
  }

  void goToTrendingProduct() {
    Get.toNamed(AppPages.newArrival, arguments: 'Trending Products');
  }

  void goToDetail(Product product) {
    Get.toNamed(AppPages.detail, arguments: product);
  }

  @override
  void onInit() async {
    getProducts();
    super.onInit();
  }
}
