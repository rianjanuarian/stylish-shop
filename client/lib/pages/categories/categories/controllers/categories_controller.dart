import 'package:client/routes/app_pages.dart';
import 'package:client/services/api_service/category/category_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  var categoryId = <Category>[].obs;
  var categoriesList = <Category>[].obs;
  var isLoading = true.obs;

  Future<void> getCategories() async {
    String url = 'https://stylish-shop.vercel.app/categories';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data;
        categoriesList.value =
            result.map((e) => Category.fromJson(e)).toList();
        isLoading.value = false;
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

  Future<void> getCategoryById(int id) async {
    String url = 'https://stylish-shop.vercel.app/products/category/$id';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        categoryId.value = [Category.fromJson(data)];
        isLoading.value = false;
        update();
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

  void goToDetailCategory(int id) {
    Get.toNamed(AppPages.detailCategory, arguments: id);
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
