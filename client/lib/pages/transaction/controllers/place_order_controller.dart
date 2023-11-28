import 'package:client/services/api_service/courier/courier_models.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../services/api_service/cart/cart_models.dart';

class PlaceOrderController extends GetxController {
  RxList<Courier> couriers = <Courier>[].obs;
  RxList<Cart> carts = <Cart>[].obs;
  RxNum totalPrice = RxNum(0);
  Rx<Courier?> selectedCourier = Rx<Courier?>(null);
  RxBool isLoading = RxBool(false);
  
  final dio = Dio();

  Future<void> getCouriers() async {
    try {
      isLoading.toggle();
      final res = await dio.get('https://stylish-shop.vercel.app/couriers');
      final List<dynamic> result = res.data;
      couriers.value = result.map((e) => Courier.fromJson(e)).toList();
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

  void setSelectedCourier(Courier? courier) {
    selectedCourier.value = courier;
    totalPrice.value += courier?.price ?? 0;
  }

  @override
  void onInit() {
    final Map<String, dynamic> argument = Get.arguments;
    totalPrice.value = argument["total"];
    carts.value = argument["carts"];
    getCouriers();
    super.onInit();
  }
}
