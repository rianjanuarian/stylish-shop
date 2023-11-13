import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isOldPasswordShow = false;
  bool _isNewPasswordShow = false;
  bool _isConfirmPasswordShow = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
          key: _formKey,
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
                  TextFormField(
                    controller: _oldPasswordController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    validator: (value) {
                      return null;
                    },
                    obscureText: _isOldPasswordShow ? false : true,
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
                        onPressed: () {
                          setState(() {
                            _isOldPasswordShow = !_isOldPasswordShow;
                          });
                        },
                        icon: Icon(_isOldPasswordShow
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  TextFormField(
                    controller: _newPasswordController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    obscureText: _isNewPasswordShow ? false : true,
                    validator: (value) {
                      if (value!.length <= 8) {
                        return 'Minimun use of 8 characters';
                      }
                      return null;
                    },
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
                        onPressed: () {
                          setState(() {
                            _isNewPasswordShow = !_isNewPasswordShow;
                          });
                        },
                        icon: Icon(_isOldPasswordShow
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  TextFormField(
                    controller: _confirmPasswordController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    obscureText: _isConfirmPasswordShow ? false : true,
                    validator: (value) {
                      if (value!.length <= 8) {
                        return 'Minimun use of 8 characters';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Your password is not matches the new password';
                      }
                      return null;
                    },
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
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordShow = !_isConfirmPasswordShow;
                          });
                        },
                        icon: Icon(_isOldPasswordShow
                            ? Icons.remove_red_eye
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(60.h),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10).r),
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
