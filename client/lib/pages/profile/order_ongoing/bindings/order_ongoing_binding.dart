import 'package:get/get.dart';

import '../controllers/order_ongoing_controller.dart';

class OrderOngoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderOngoingController>(
      () => OrderOngoingController(),
    );
  }
}
