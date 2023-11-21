import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController oldPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  RxBool isLoading = RxBool(false);
  RxBool isOldPasswordShow = RxBool(false);
  RxBool isNewPasswordShow = RxBool(false);
  RxBool isConfirmPasswordShow = RxBool(false);

  String? oldPasswordValidation(value) {
    return null;
  }

  String? newPasswordValidation(value) {
    if (value!.length <= 8) {
      return 'Minimun use of 8 characters';
    }
    return null;
  }

  String? confirmPasswordValidation(value) {
    if (value!.length <= 8) {
      return 'Minimun use of 8 characters';
    }
    if (value != newPasswordController.text) {
      return 'Your password is not matches the new password';
    }
    return null;
  }

  void changePassword() async {
    if (formKey.currentState!.validate()) {
      // change the password! not implemented yet.
      try {} catch (e) {
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

    void clearTextFieldProp() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    }

  @override
  void onInit() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    clearTextFieldProp();
    super.dispose();
  }
}
