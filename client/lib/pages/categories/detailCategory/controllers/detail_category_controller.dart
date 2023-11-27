import 'package:client/routes/app_pages.dart';
import 'package:client/services/api_service/category/category_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DetailCategoryController extends GetxController {
  Rx<Category?> category = Rx<Category?>(null);
  RxBool isLoading = RxBool(false);

  Future<void> getCategoryById(int id) async {
    String url = 'https://stylish-shop.vercel.app/products/category/$id';
    try {
      isLoading.toggle();
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        if (response.data != null) {
          final data = response.data;
          category.value = Category.fromJson(data);
        } else {
          Get.snackbar('Error', 'Response data is null');
        }
      }
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          if (errorResponse.data is Map) {
            final errorMessage = errorResponse.data['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
        }
      } else {
        Get.snackbar(
          'Error',
          e.toString(),
          borderWidth: 0.2,
          duration: const Duration(seconds: 2),
        );
      }
    } finally {
      isLoading.toggle();
    }
  }

  void goToDetail(product) {
    Get.toNamed(AppPages.detail, arguments: product);
  }

  void goToSearch() {
    Get.toNamed(AppPages.search);
  }

  @override
  void onInit() {
    int id = Get.arguments;
    getCategoryById(id);
    super.onInit();
  }
}
