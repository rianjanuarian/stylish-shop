import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/api_service/api_service.dart';
import '../../../services/api_service/api_service_models.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  late FocusNode usernameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  var passwordObscure = true.obs;
  var isPasswordObscure = true.obs;
  RxBool isLoading = false.obs;

  // Username
  final usernameChange = RxString('');

  // Email
  final emailChange = RxString('');

  // Password
  final passwordChange = RxString('');

  // Confirm Password
  final confirmPasswordChange = RxString('');

  // ApiService Init
  final apiService = Get.put(ApiServiceImpl());

  // Firebase init
  final auth = FirebaseAuth.instance;

  void clearTextFieldProp() {
    username.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  void onObsecurePasswordTapped() {
    passwordObscure.toggle();
  }

  void onObsecureConfirmPasswordTapped() {
    isPasswordObscure.toggle();
  }

  String? usernameValidators(value) {
    if (value.length == 0) {
      return 'Please enter username';
    }
    return null;
  }

  String? emailValidations(value) {
    if (value.length == 0) {
      return 'Please enter an email';
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
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? confirmPasswordValidations(value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (value != password.text) {
      return 'Password does not match';
    }
    return null;
  }

  void signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        await auth.createUserWithEmailAndPassword(
            email: email.text, password: password.text);

        await apiService.registerWithEmail(RegisterRequest(
          name: username.text,
          email: email.text,
          password: password.text,
          uid: auth.currentUser!.uid,
        ));
        Get.offNamed('/login');
        isLoading.value = false;
      } catch (e) {
        if (e is DioException) {
          final errorResponse = e.response;
          if (errorResponse != null) {
            final errorMessage = errorResponse.data?['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
          isLoading.value = false;
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
    clearTextFieldProp();
  }
}
