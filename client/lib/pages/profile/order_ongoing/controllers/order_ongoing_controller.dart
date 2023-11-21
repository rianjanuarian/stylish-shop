import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrderOngoingController extends GetxController {
  RxBool isLoading = RxBool(false);
  RxBool isOngoing = RxBool(true);

  //dummy ongoing orders
  final List orderOnGoing = [
    {
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Adibas',
      'description': 'Adibas good shoes',
      'price': 150,
    },
    {
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Mike',
      'description': 'Mike good shoes',
      'price': 170,
    }
  ].obs;

  //dummy completed orders
  final List orderCompleted = [
    {
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Swallaw',
      'description': 'Swallaw good sandals',
      'price': 150,
    }
  ].obs;

  void switchTo(bool value) {
    isOngoing.value = value;
  }

  void getOngoingOrder() async {
    try {
      isLoading.toggle();
      //fetch ongoing orders
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

  @override
  void onInit() {
    getOngoingOrder();
    super.onInit();
  }
}
