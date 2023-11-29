import 'package:stylish_shop/routes/app_pages.dart';
import 'package:stylish_shop/services/keys/get_storage_key.dart';
import 'package:stylish_shop/services/storage_service/storage_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var storageService = Get.put(StorageService());

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      getToken() == null
          ? Get.offAllNamed(AppPages.onBoarding)
          : Get.offAllNamed(AppPages.mainTab);
    });
  }

  String? getToken() {
    return storageService.read(GetStorageKey.token);
  }
}
