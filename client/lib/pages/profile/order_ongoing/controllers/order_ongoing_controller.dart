import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stylish_shop/services/api_service/transaction/transaction_model.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/keys/get_storage_key.dart';

class OrderOngoingController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isOngoing = RxBool(true);
  final dio = Dio();
  final storage = GetStorage();

  RxList<Transaction> onGoing = <Transaction>[].obs;
  RxList<Transaction> onCompleted = <Transaction>[].obs;

  void switchTo(bool value) {
    isOngoing.value = value;
  }

  void getOngoingOrder() async {
    try {
      isLoading.toggle();
      //fetch ongoing orders
      final token = await storage.read(GetStorageKey.token);

      final response = await dio.get(
        'https://stylish-shop.vercel.app/transactions/transaction-user',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      final List<dynamic> result = response.data;
      var arr = result.map((data) => Transaction.fromJson(data)).toList();
      onGoing.value = arr.where((element) => element.status == Status.pending).toList();
      onCompleted.value = arr.where((element) => element.status == Status.approve).toList();
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
      } else {
        Get.snackbar('Error', 'Unknown error occurred');
      }
    } finally {
      isLoading.toggle();
    }
  }

  void goToPayment(String midtransToken){
    try {
      final paymentUrl = 'https://app.sandbox.midtrans.com/snap/v2/vtweb/$midtransToken';
      Get.toNamed(AppPages.transactionWebView, arguments: paymentUrl);
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
      } else {
        Get.snackbar('Error', 'Unknown error occurred');
      }
    }
  }

  @override
  void onInit() {
    getOngoingOrder();
    super.onInit();
  }
}
