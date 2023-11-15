import 'package:client/pages/signup/controllers/signup_controller.dart';
import 'package:client/themes/const.dart';
import 'package:client/utils/costom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: KeyboardVisibilityBuilder(
            builder: (p0, isKeyboardVisible) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isKeyboardVisible)
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset('assets/logo/logo_light.png')),
                  if (isKeyboardVisible) SizedBox(height: 50.h),
                  Text(
                    'Join Us!',
                    style:
                        TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Register now and get your benefit',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w200,
                        color: const Color(0xff9D9B9B)),
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          controller: controller.username,
                          keyboardType: TextInputType.name,
                          validator: controller.usernameValidators,
                          onChanged: (value) {
                            controller.usernameChange.value = value;
                          },
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultRadius).r,
                          ),
                          hintText: 'Enter Username',
                          contentPadding: const EdgeInsets.only(left: 20),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          controller: controller.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.emailValidations,
                          onChanged: (value) {
                            controller.emailChange.value = value;
                          },
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultRadius).r,
                          ),
                          hintText: 'Enter Email',
                          contentPadding: const EdgeInsets.only(left: 20),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => CustomTextFormField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            controller: controller.password,
                            keyboardType: TextInputType.visiblePassword,
                            validator: controller.passwordValidations,
                            onChanged: (value) {
                              controller.passwordChange.value = value;
                            },
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius).r,
                            ),
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: 'Enter Password',
                            suffix: IconButton(
                              icon: Icon(
                                controller.passwordObscure.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                controller.onObsecurePasswordTapped();
                              },
                            ),
                            obscureText: controller.passwordObscure.value,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => CustomTextFormField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            controller: controller.confirmPassword,
                            keyboardType: TextInputType.visiblePassword,
                            validator: controller.confirmPasswordValidations,
                            onChanged: (value) {
                              controller.confirmPasswordChange.value = value;
                            },
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius).r,
                            ),
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: 'Enter Confirm Password',
                            suffix: IconButton(
                              icon: Icon(
                                controller.isPasswordObscure.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                controller.onObsecureConfirmPasswordTapped();
                              },
                            ),
                            obscureText: controller.isPasswordObscure.value,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Obx(
                          () => ElevatedButton(
                            onPressed: controller.isLoading.isTrue
                                ? null
                                : () => controller.signUp(),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(60.h),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: controller.isLoading.isTrue
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Sign Up'),
                          ),
                        ),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
