import 'package:client/services/api_service/api_service.dart';
import 'package:client/services/api_service/api_service_models.dart';
import 'package:client/services/keys/get_storage_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController email;
  late final TextEditingController password;

  RxBool isLoading = false.obs;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  var isPasswordObscure = true.obs;

  // Email
  final emailChange = RxString('');

  // Password
  final passwordChange = RxString('');

  // storage
  final storage = GetStorage();

  // ApiService
  final apiService = ApiServiceImpl();

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
      formKey.currentState!.save();
      isLoading.value = true;

      // Masih error, tolong bantu yang ini ya :)
      try {
        await Future.delayed(const Duration(milliseconds: 5000));
        final response = await apiService.auth(
          LoginRequest()
            ..email = emailChange.value
            ..password = passwordChange.value,
        );
        print("Response: ${response.statusCode}");

        final loginPayload = response.payload;

        if (response.payload != null) {
          await storage.write(GetStorageKey.token, loginPayload!.token);
          Get.offAllNamed('/main-tab');
          isLoading.value = false;
        } else {
          Get.snackbar('Error', response.message!);
          isLoading.value = false;
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
        isLoading.value = false;
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
