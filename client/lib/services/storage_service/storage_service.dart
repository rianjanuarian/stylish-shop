import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  Future<StorageService> init() async {
    await GetStorage.init();
    return this;
  }

  void write(String key, String value) {
    GetStorage().write(key, value);
  }

  dynamic read(String key) {
    return GetStorage().read(key);
  }

  dynamic remove(String key) {
    return GetStorage().remove(key);
  }
}
