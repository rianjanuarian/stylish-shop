import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: REdgeInsets.symmetric(vertical: 10, horizontal: 30),
                padding: REdgeInsets.all(10),
                height: 0.13.sh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.r,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10).r,
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                        height: 90.h,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sarah',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'sarah@gmail.com',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF8E8E8E)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: REdgeInsets.symmetric(vertical: 20, horizontal: 30),
                padding: REdgeInsets.symmetric(vertical: 10),
                height: 0.25.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: const Color(0xFF938585),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding:  REdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Account',
                        style: TextStyle(
                            fontSize: 15.sp, color: const Color(0xFF938585)),
                      ),
                    ),
                    IconText(
                      icon: Icons.person_2_outlined,
                      text: 'Personal Details',
                      handleClick: () => Get.toNamed('/personal-detail'),
                    ),
                    IconText(
                      icon: Icons.list,
                      text: 'My Order',
                      handleClick: () => Get.toNamed('/order-ongoing'),
                    ),
                    IconText(
                      icon: Icons.password,
                      text: 'Change Password',
                      handleClick: () => Get.toNamed('/change-password'),
                    )
                  ],
                ),
              ),
              Container(
                margin: REdgeInsets.symmetric(vertical: 20, horizontal: 30),
                padding: REdgeInsets.symmetric(vertical: 10),
                height: 0.25.sh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: const Color(0xFF938585),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Other Info',
                        style: TextStyle(
                            fontSize: 15.sp, color: const Color(0xFF938585)),
                      ),
                    ),
                    IconText(
                      icon: Icons.business,
                      text: 'Privacy Policy',
                      handleClick: () => Get.toNamed('/privacy-policy'),
                    ),
                    IconText(
                      icon: Icons.leaderboard_outlined,
                      text: 'Term & Conditions',
                      handleClick: () => Get.toNamed('/term-condition'),
                    ),
                    IconText(
                      icon: Icons.list_alt_outlined,
                      text: 'About & Services',
                      handleClick: () => Get.toNamed('/about-service'),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    REdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed('/login'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(60.h),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  child: const Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconText extends StatelessWidget {
  const IconText(
      {super.key,
      required this.icon,
      required this.text,
      required this.handleClick});
  final IconData icon;
  final String text;
  final VoidCallback handleClick;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: handleClick,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30.sp,
              ),
              SizedBox(width: 20.w),
              Text(
                text,
                style: TextStyle(fontSize: 15.sp),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, size: 30.sp)
            ],
          ),
        ),
      ),
    );
  }
}
