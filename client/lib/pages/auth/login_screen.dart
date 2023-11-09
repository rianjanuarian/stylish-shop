import 'package:client/pages/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    child: Image.asset('assets/logo/logo_light.png'),
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
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter Email',
                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Enter Password',
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: Color(0xFF8C8C8C),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () => Get.offAllNamed('/home'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize: Size.fromHeight(60.h)),
                      child: const Text('Login'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: REdgeInsets.symmetric(horizontal: 10),
                            height: 1.h,
                            color: Colors.black,
                          ),
                        ),
                        const Text('Or'),
                        Expanded(
                          child: Container(
                            margin: REdgeInsets.symmetric(horizontal: 10),
                            height: 1.h,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: ()  => Get.offAllNamed('/home'),
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
