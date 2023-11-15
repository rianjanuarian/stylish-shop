import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailCategory extends StatelessWidget {
  const DetailCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80.w,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          style: IconButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
        ),
        surfaceTintColor: Colors.white,
        title: Text(
          'About & Services',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              //pergi ke halaman search
            },
          ),
        ],
      ),
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.all(30),
          child: const Column(
            children: [
              Text('Clothes'),
              //widget products 
            ],
          ),
        ),
      ),
    );
  }
}
