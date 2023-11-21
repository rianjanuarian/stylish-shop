import 'package:get/get.dart';

import '../controllers/personal_detail_controller.dart';

class PersonalDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalDetailController>(
      () => PersonalDetailController(),
    );
  }
}
