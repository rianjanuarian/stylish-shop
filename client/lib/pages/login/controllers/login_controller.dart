import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  var passwordObscure = true.obs;

  // Email
  final emailError = RxString('');
  final emailChange = RxString('');

  // Password
  final passwordError = RxString('');
  final passwordChange = RxString('');

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    email = TextEditingController();
    password = TextEditingController();

    emailValidation();
    passwordValidation();
  }

  @override
  void dispose() {
    super.dispose();
    clearTextFieldProp();
  }

  void clearTextFieldProp() {
    email.clear();
    password.clear();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  void onObsecurePasswordTapped() {
    passwordObscure.toggle();
  }

  void emailValidation() {
    if (email.text == '' || email.text.isEmpty) {
      emailError.value = 'Please enter email';
    } else if (!GetUtils.isEmail(email.text)) {
      emailError.value = 'Please enter valid email';
    } else {
      // Clear the error if email is valid
      emailChange.value = email.text;
      emailError.value = '';
    }
  }

  void passwordValidation() {
    if (password.text == '' || password.text.isEmpty) {
      passwordError.value = 'Please enter password';
    } else {
      // Clear the error if password is valid
      passwordChange.value = password.text;
      passwordError.value = '';
    }
  }
}
