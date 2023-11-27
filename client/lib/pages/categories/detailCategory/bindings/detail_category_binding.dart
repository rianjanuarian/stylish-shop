import 'package:get/get.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCategoryController>(
      () => DetailCategoryController(),
    );
  }
}
