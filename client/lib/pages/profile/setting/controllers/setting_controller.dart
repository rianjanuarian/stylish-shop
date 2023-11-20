import 'package:client/services/keys/get_storage_key.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {

  final storage = GetStorage();

  void getUser() async {
    try {
      final token = await storage.read(GetStorageKey.token);
       
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }


  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
