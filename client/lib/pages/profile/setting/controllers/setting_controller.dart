import 'package:client/services/keys/get_storage_key.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingController extends GetxController {
  final storage = GetStorage();

  // Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void getUser() async {
    try {
      final token = await storage.read(GetStorageKey.token);
      //do things with the token
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }

  void logOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      await GetStorage().remove(GetStorageKey.token);
      Get.offAllNamed('/login');
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
