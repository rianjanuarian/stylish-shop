
import 'package:client/models/categories.dart';
import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

//var productList = <Products>[].obs;

class CategoriesController extends GetxController {
  //dummy categories
  final List<String> categoryDummies = [
    'New Arrival',
    'Clothes',
    'Bags',
    'Shoes',
    'Electronics',
    'Jewelery'
  ].obs;
  var categoriesList = <Categories>[].obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();

    getCategories();
  }
// Future<void> getProducts() async {
//     String url = 'https://stylish-shop.vercel.app/products';

//     try {
//       final response = await Dio().get(
//         url,
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> result = response.data;
   
//         productList.value = result.map((e) => Products.fromJson(e)).toList();
//         trendingList.value = result.map((e) => Products.fromJson(e)).toList();
//         isLoading.value = false;

//         update();
//       } else {
//         Get.snackbar(
//             'error fetching data', 'error : ${response.statusCode.toString()}');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
  Future<void> getCategories() async {
    String url = 'https://stylish-shop.vercel.app/categories';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data;
        categoriesList.value = result.map((e) => Categories.fromJson(e)).toList();
        isLoading.value = false;
        print(result);
        update();
      } else {
        Get.snackbar(
            'error fetching data', 'error : ${response.statusCode.toString()}');
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
        isLoading.value = true;
      }
    }
  }
  // void getCategories() {
  //   try {
  //     isLoading.toggle();
  //     //get categories
  //   } catch (e) {
  //     if (e is DioException) {
  //       final errorResponse = e.response;
  //       if (errorResponse != null) {
  //         final errorMessage = errorResponse.data?['message'];
  //         Get.snackbar('Error', errorMessage ?? 'Unknown error');
  //       } else {
  //         Get.snackbar('Error', 'Unknown error occurred');
  //       }
  //       isLoading.toggle();
  //     }
  //   }
  // }

  void goToSpecificCategory(categoryName) async {
    try {
      isLoading.toggle();
      //get categories
      switch (categoryName) {
        case 'New Arrival':
          Get.toNamed(AppPages.newArrival);
          break;
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
        isLoading.toggle();
      }
    }
  }

  void goToSearch() {
    Get.toNamed(AppPages.search);
  }

 
}
