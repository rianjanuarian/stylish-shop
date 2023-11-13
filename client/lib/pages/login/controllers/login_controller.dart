import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  var passwordObscure = true.obs;
  final emailError = RxString('');
  final emailChange = RxString('');

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    email = TextEditingController();
    password = TextEditingController();

    emailValidation();
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
}
