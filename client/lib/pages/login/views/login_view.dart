import 'package:client/pages/login/controllers/login_controller.dart';
import 'package:client/themes/color.dart';
import 'package:client/themes/const.dart';
import 'package:client/widgets/costom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: KeyboardVisibilityBuilder(
            builder: (p0, isKeyboardVisible) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isKeyboardVisible)
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/logo/logo_light.png',
                      height: 200.h,
                    ),
                  ),
                if (isKeyboardVisible) SizedBox(height: 50.h),
                Text(
                  'We\'re so excited to see you again',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w300,
                    color: const Color(0xFF8C8C8C),
                  ),
                ),
                Text(
                  'Welcome back!',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
                ),
                SizedBox(height: 20.h),
                Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          controller: controller.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: controller.emailValidations,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultRadius).r,
                          ),
                          hintText: 'Enter Email',
                          prefix: Icon(
                            Icons.alternate_email,
                            color: CustomColor.iconColor,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Password',
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => CustomTextFormField(
                            onTapOutside: (event) =>
                                FocusScope.of(context).unfocus(),
                            controller: controller.password,
                            keyboardType: TextInputType.visiblePassword,
                            validator: controller.passwordValidations,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius).r,
                            ),
                            hintText: 'Enter Password',
                            prefix: Icon(
                              Icons.lock_outlined,
                              color: CustomColor.iconColor,
                            ),
                            suffix: IconButton(
                              icon: Icon(
                                controller.isPasswordObscure.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                              ),
                              onPressed: () {
                                controller.onObsecurePasswordTapped();
                              },
                            ),
                            obscureText: controller.isPasswordObscure.value,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Obx(
                          () => ElevatedButton(
                            onPressed: controller.isLoading.isTrue
                                ? null
                                : () => controller.loginWithEmail(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                minimumSize: Size.fromHeight(60.h)),
                            child: controller.isLoading.isTrue
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Login'),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                height: 1.h,
                                thickness: 2,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ),
                            const Text('Or'),
                            Expanded(
                              child: Divider(
                                color: Colors.black,
                                height: 1.h,
                                thickness: 2,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => controller.loginWithGoogle(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              minimumSize: Size.fromHeight(60.h)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/logo/google.png'),
                              Text(
                                'Continue with Google',
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
