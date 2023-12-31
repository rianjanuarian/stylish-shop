import 'package:stylish_shop/routes/app_pages.dart';
import 'package:stylish_shop/services/api_service/api_service.dart';
import 'package:stylish_shop/services/api_service/api_service_models.dart';
import 'package:stylish_shop/services/keys/get_storage_key.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController email;
  late final TextEditingController password;
  RxBool isLoading = false.obs;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  var isPasswordObscure = true.obs;

  // Firebase
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  // storage
  final storage = GetStorage();

  // ApiService Init
  final apiService = Get.put(ApiServiceImpl());

  void clearTextFieldProp() {
    email.clear();
    password.clear();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void onObsecurePasswordTapped() {
    isPasswordObscure.toggle();
  }

  String? emailValidations(value) {
    if (value.length == 0) {
      return 'Please enter an email address';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidations(value) {
    if (value.length == 0) {
      return 'Please enter a password';
    }
    return null;
  }

  void loginWithEmail() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        final response = await apiService.loginWithEmail(
          LoginRequest()
            ..email = email.text
            ..password = password.text,
        );
        final loginPayload = response.payload;
        await storage.write(GetStorageKey.token, loginPayload!.access_token);
        Get.offAllNamed(AppPages.mainTab);
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
        }
        if (e is FirebaseAuthException) {
          Get.snackbar(
            'Error',
            e.message ?? 'Unknown error',
            backgroundColor: Colors.grey.shade300,
            borderWidth: 0.2,
            duration: const Duration(seconds: 2),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  void loginWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final authentication = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: authentication.accessToken,
          idToken: authentication.idToken,
        );

        await auth.signInWithCredential(credential);

        final response = await apiService.loginWithGoogle(
            googleUser.email, auth.currentUser!.uid, googleUser.displayName);
        await storage.write(GetStorageKey.token, response.data["access_token"]);
        Get.offAllNamed(AppPages.mainTab);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        Get.snackbar('Error', e.message ?? 'Unknown error');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    clearTextFieldProp();
  }
}
