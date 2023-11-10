import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedTwoScreen extends StatelessWidget {
  const GetStartedTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(20).w,
              bottomRight: const Radius.circular(20).w,
            ),
            child: Image.asset(
              'assets/images/baju2.png',
              width: double.infinity,
              height: 0.65.sh,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: REdgeInsets.only(right: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Discover New \nFashion',
                  style: GoogleFonts.playfair(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 36.sp,
                    height: 1.h,
                  ),
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 20.h),
                Text(
                  'It brings your the latets trends and \nproducts from the world...',
                  style: GoogleFonts.playfair(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(top: 20),
                  child: IconButton(
                    onPressed: () => Get.offAllNamed('/auth'),
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.white,
                    style: IconButton.styleFrom(backgroundColor: Colors.black),
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
