import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 80.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
        ),
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    'Change Password',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 32.sp),
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                    () => TextFormField(
                      controller: controller.oldPasswordController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      validator: controller.oldPasswordValidation,
                      obscureText:
                          controller.isOldPasswordShow.isTrue ? false : true,
                      decoration: InputDecoration(
                        contentPadding: REdgeInsets.only(left: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF666666),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF666666), width: 2),
                        ),
                        hintText: 'Old Password',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              controller.isOldPasswordShow.toggle(),
                          icon: Icon(controller.isOldPasswordShow.value
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                    () => TextFormField(
                      controller: controller.newPasswordController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      obscureText:
                          controller.isNewPasswordShow.isTrue ? false : true,
                      validator: controller.newPasswordValidation,
                      decoration: InputDecoration(
                        contentPadding: REdgeInsets.only(left: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF666666),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF666666), width: 2),
                        ),
                        hintText: 'New Password',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              controller.isNewPasswordShow.toggle(),
                          icon: Icon(controller.isNewPasswordShow.value
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                    () => TextFormField(
                      controller: controller.confirmPasswordController,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      obscureText: controller.isConfirmPasswordShow.isTrue
                          ? false
                          : true,
                      validator: controller.confirmPasswordValidation,
                      decoration: InputDecoration(
                        contentPadding: REdgeInsets.only(left: 30),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF666666),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF666666), width: 2),
                        ),
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                          onPressed: () =>
                              controller.isConfirmPasswordShow.toggle(),
                          icon: Icon(
                            controller.isConfirmPasswordShow.isTrue
                                ? Icons.remove_red_eye
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => controller.changePassword(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(60.h),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10).r,
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                  SizedBox(height: 100.h),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
