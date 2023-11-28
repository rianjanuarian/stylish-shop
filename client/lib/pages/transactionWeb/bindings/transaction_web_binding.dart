import 'package:get/get.dart';

import '../controllers/transaction_web_controller.dart';

class TransactionWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionWebController>(
      () => TransactionWebController(),
    );
  }
}
