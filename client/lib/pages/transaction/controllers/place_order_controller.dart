import 'package:client/services/api_service/courier/courier_models.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/api_service/cart/cart_models.dart';
import '../../../services/keys/get_storage_key.dart';

class PlaceOrderController extends GetxController {
  RxList<Courier> couriers = <Courier>[].obs;
  RxList<Cart> carts = <Cart>[].obs;
  RxNum totalPrice = RxNum(0);
  Rx<Courier?> selectedCourier = Rx<Courier?>(null);
  RxBool isLoading = RxBool(false);

  final dio = Dio();
  final storage = GetStorage();

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

  Future<void> placeOrder() async {
    try {
      isLoading.toggle();
      int? id = selectedCourier.value?.id;
      final token = await storage.read(GetStorageKey.token);
      final res = await dio.post(
        'https://stylish-shop.vercel.app/transactions/create/$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      Get.snackbar(
        'Success',
        res.data?['message'],
      );
      openUrl(
          'https://app.sandbox.midtrans.com/snap/v3/redirection/${res.data['userPay']['midtranstoken']}');
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
    } finally {
      isLoading.toggle();
    }
  }

  void openUrl(String urlToken) async {
    final Uri url = Uri.parse(urlToken);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    } else {
      Get.snackbar('Error', 'Could not launch $url');
    }
  }

  void setSelectedCourier(Courier? courier) {
    totalPrice.value -= selectedCourier.value?.price ?? 0;
    selectedCourier.value = courier;
  }

  num get courierFee {
    if (selectedCourier.value == null) {
      return 0;
    } else {
      return selectedCourier.value!.price ?? 0;
    }
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
