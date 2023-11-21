import 'package:client/services/api_service/user/user_service_models.dart';
import 'package:client/services/keys/get_storage_key.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingController extends GetxController {
  final storage = GetStorage();

  // Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final dio = Dio();

  Future<UserModel> getUser() async {
    try {
      final token = await storage.read(GetStorageKey.token);
      final res = await dio.get('https://stylish-shop.vercel.app/users/getUser',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }));
      return UserModel.fromJson(res.data);
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          throw errorResponse.data?['message'];
        }
      }
      rethrow;
    }
  }

  void logOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      await GetStorage().remove(GetStorageKey.token);
      await dio.get('https://stylish-shop.vercel.app/users/logout');
      Get.offAllNamed('/login');
    } catch (e) {
      if (e is DioException) {
        final errorResponse = e.response;
        if (errorResponse != null) {
          Get.snackbar('error', errorResponse.data?['message']);
        }
      }
    }
  }
}
