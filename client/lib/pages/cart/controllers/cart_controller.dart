import 'package:client/routes/app_pages.dart';
import 'package:client/services/api_service/cart/cart_models.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../services/keys/get_storage_key.dart';

class CartController extends GetxController {
  RxList<Cart> carts = <Cart>[].obs;
  RxBool isLoading = RxBool(false);
  final dio = Dio();
  final storage = GetStorage();
  int initialProductPrice = 200000;
  RxBool isCartEmpty = RxBool(false);

  Future<void> getCart() async {
    try {
      isLoading.toggle();
      //fetch carts from api
      final token = await storage.read(GetStorageKey.token);
      final res = await dio.get('https://stylish-shop.vercel.app/carts/user',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      final List<dynamic> result = res.data;
      carts.value = result.map((e) => Cart.fromJson(e)).toList();
      isCartEmpty.value = checkIsCartEmpty(); 
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
    }
  }

  bool checkIsCartEmpty() {
    if (carts.isEmpty) {
      return true;
    }
    return false;
  }

  void removeCart(int id) async {
    try {
      final token = await storage.read(GetStorageKey.token);
      await dio.delete('https://stylish-shop.vercel.app/carts/delete/$id',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      carts.removeWhere((cart) => cart.id == id);
      isCartEmpty.value = checkIsCartEmpty();
      Get.back();
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

  void addQuantity(int id) async {
    try {
      carts.value = carts.map((cart) {
        if (cart.id == id) {
          cart.qty = (cart.qty ?? 0) + 1;
          cart.total_price = (cart.product?.price ?? 0) * (cart.qty ?? 0);
        }
        return cart;
      }).toList();
      final token = await storage.read(GetStorageKey.token);
      final qty = carts.firstWhere((cart) => cart.id == id).qty;
      await dio.put('https://stylish-shop.vercel.app/carts/update/$id',
          data: {"qty": qty},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      update();
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

  void substractQuantity(int id) async {
    try {
      carts.value = carts.map((cart) {
        if (cart.id == id) {
          cart.qty = (cart.qty ?? 0) - 1;
          cart.total_price = (cart.product?.price ?? 0) * (cart.qty ?? 0);
        }
        return cart;
      }).toList();
      final token = await storage.read(GetStorageKey.token);
      final qty = carts.firstWhere((cart) => cart.id == id).qty;
      await dio.put('https://stylish-shop.vercel.app/carts/update/$id',
          data: {"qty": qty},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      update();
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
    getCart();
    super.onInit();
  }
}
