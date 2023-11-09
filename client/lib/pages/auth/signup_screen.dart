import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10).r,
                            ),
                            contentPadding: REdgeInsets.only(left: 20),
                            hintText: 'Enter Email',
                          ),
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
                        TextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: REdgeInsets.only(left: 20),
                            hintText: 'Enter Password',
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
                        TextFormField(
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10).r,
                            ),
                            contentPadding: REdgeInsets.only(left: 20),
                            hintText: 'Enter Confirm Password',
                          ),
                        ),
                        SizedBox(height: 25.h),
                        ElevatedButton(
                          onPressed: () => Get.offAllNamed('/login'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(60.h),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Sign Up'),
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
