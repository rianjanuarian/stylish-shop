import 'package:get/get.dart';

import '../controllers/new_arrival_controller.dart';

class NewArrivalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewArrivalController>(
      () => NewArrivalController(),
    );
  }
}
