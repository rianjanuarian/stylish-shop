import 'package:client/pages/signup/controllers/signup_controller.dart';
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
                        TextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          validator: controller.usernameValidators,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10).r,
                            ),
                            contentPadding: REdgeInsets.only(left: 20),
                            hintText: 'Enter Username',
                          ),
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
                        TextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          controller: controller.email,
                          validator: controller.emailValidations,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10).r,
                            ),
                            contentPadding: REdgeInsets.only(left: 20),
                            hintText: 'Enter Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            controller.emailChange.value = value;
                            controller.emailValidation();
                          },
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
                          () => TextFormField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            controller: controller.password,
                            validator: controller.passwordValidations,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: REdgeInsets.only(left: 20),
                              hintText: 'Enter Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.passwordObscure.value
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                ),
                                onPressed: () {
                                  controller.onObsecurePasswordTapped();
                                },
                              ),
                            ),
                            onChanged: (value) {
                              controller.passwordChange.value = value;
                              controller.passwordValidation();
                            },
                            obscureText: controller.passwordObscure.value,
                            keyboardType: TextInputType.visiblePassword,
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
                          () => TextFormField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            controller: controller.confirmPassword,
                            validator: controller.confirmPasswordValidations,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10).r,
                              ),
                              contentPadding: REdgeInsets.only(left: 20),
                              hintText: 'Enter Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.confirmPasswordObscure.value
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.remove_red_eye,
                                ),
                                onPressed: () {
                                  controller.onObsecureConfirmPasswordTapped();
                                },
                              ),
                            ),
                            onChanged: (value) {
                              controller.confirmPasswordChange.value = value;
                              controller.confirmPasswordValidation();
                            },
                            obscureText:
                                controller.confirmPasswordObscure.value,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Obx(
                          () => ElevatedButton(
                            onPressed: () => controller.isLoading.isTrue
                                ? null
                                : controller.signUp(),
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
