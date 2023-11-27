import 'package:client/routes/app_pages.dart';
import 'package:client/services/api_service/user/user_service_models.dart';
import 'package:client/services/keys/get_storage_key.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingController extends GetxController {
  final storage = GetStorage();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isLoading = RxBool(false);

  // Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final dio = Dio();

  Future<void> getUser() async {
    try {
      isLoading.toggle();
      final token = await storage.read(GetStorageKey.token);
      final res = await dio.get('https://stylish-shop.vercel.app/users/getUser',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      user.value = UserModel.fromJson(res.data);
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          if (errorResponse.data is Map) {
            final errorMessage = errorResponse.data['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
        }
      } else {
        Get.snackbar(
          'Error',
          e.toString(),
          borderWidth: 0.2,
          duration: const Duration(seconds: 2),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void logOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      await GetStorage().remove(GetStorageKey.token);
      await dio.get('https://stylish-shop.vercel.app/users/logout');
      Get.offAllNamed(AppPages.login);
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          Get.snackbar('error', errorResponse.data?['message']);
        }
      }
    }
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
