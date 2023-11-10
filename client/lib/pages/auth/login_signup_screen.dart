import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo/logo_dark.png',
              width: 320.w,
            ),
          ),
          Positioned(
            bottom: 0.05.sh,
            child: SizedBox(
              width: 1.sw,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.toNamed('/login'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(60.h),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Login'),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => Get.toNamed('/signup'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(60.h),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(
                              side: BorderSide(color: Colors.white))),
                      child: const Text('Sign Up'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  