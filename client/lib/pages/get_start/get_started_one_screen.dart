import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedOneScreen extends StatelessWidget {
  const GetStartedOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(20).w,
              bottomRight: const Radius.circular(20).w,
            ),
            child: Image.asset(
              'assets/images/baju1.png',
              width: double.infinity,
              height: 0.65.sh,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: REdgeInsets.only(left: 20,top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explore \nTrendy Fashion',
                  style: GoogleFonts.playfair(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 36.sp,
                    height: 1.h,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Explore the 2023’s hottest fashion in the \namazing world',
                  style: GoogleFonts.playfair(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
