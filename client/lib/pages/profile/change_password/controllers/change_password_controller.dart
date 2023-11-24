import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../services/keys/get_storage_key.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController oldPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;
  final storage = GetStorage();

  RxBool isLoading = RxBool(false);
  RxBool isOldPasswordShow = RxBool(false);
  RxBool isNewPasswordShow = RxBool(false);
  RxBool isConfirmPasswordShow = RxBool(false);

  String? oldPasswordValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Please insert an old password';
    }
    return null;
  }

  String? newPasswordValidation(value) {
    if (value!.length < 8) {
      return 'Minimun use of 8 characters';
    }
    return null;
  }

  String? confirmPasswordValidation(value) {
    if (value != newPasswordController.text) {
      return 'Your password is not matches the new password';
    }
    return null;
  }

  void changePassword() async {
    if (formKey.currentState!.validate()) {
      try {
        final dio = Dio();
        isLoading.toggle();
        final token = await storage.read(GetStorageKey.token);
        final Map<String, dynamic> passwordData = {
          'oldPassword': oldPasswordController.text,
          'newPassword': newPasswordController.text,
          'confirmPassword': confirmPasswordController.text,
        };
        final res = await dio.put(
          'https://stylish-shop.vercel.app/users/change_password',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }),
          data: passwordData,
        );
        Get.snackbar('Success', res.data?['message']);
        await storage.remove(GetStorageKey.token);
        Get.offAllNamed(AppPages.login);
      } catch (e) {
        if (e is DioException) {
          final errorResponse = e.response;
          if (errorResponse != null) {
            final errorMessage = errorResponse.data?['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
          isLoading.toggle();
        }
        isLoading.toggle();
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
