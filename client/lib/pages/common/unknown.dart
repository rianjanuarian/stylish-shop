import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Unknown extends StatelessWidget {
  const Unknown({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          '404 Check Your Route',
          style: TextStyle(color: Colors.white, fontSize: 24.sp),
        ),
      ),
    );
  }
}
