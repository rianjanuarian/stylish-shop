import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

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

  RxBool isLoading = RxBool(false);

  void getCategories() {
    try {
      isLoading.toggle();
      //get categories
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

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }
}
