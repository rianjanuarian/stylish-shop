import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      await Future.delayed(const Duration(milliseconds: 5000));
      Get.offAllNamed('/main-tab');
      isLoading.value = false;
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
