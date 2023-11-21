import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../controllers/personal_detail_controller.dart';

class PersonalDetailView extends GetView<PersonalDetailController> {
  const PersonalDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget nameWithInput() {
      return Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Name',
                style: TextStyle(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 15.sp,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: controller.nameController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration:  InputDecoration(
                  contentPadding: REdgeInsets.all(5),
                  isDense: true,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB4B4B4),
                    ),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB4B4B4),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFB4B4B4), width: 2),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget genderWithCheck() {
      return Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Gender',
              style: TextStyle(
                color: const Color(0xFFB4B4B4),
                fontSize: 15.sp,
              ),
            ),
            SizedBox(width: 50.w),
            Row(
              children: [
                Obx(
                  () => Material(
                    color: controller.gender.value == Gender.male
                        ? Colors.black
                        : Colors.white,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.r),
                      onTap: () => controller.changeGenderToMale(),
                      child: Container(
                        width: 80.w,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 5.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              controller.gender.value == Gender.male
                                  ? Icons.brightness_1
                                  : Icons.brightness_1_outlined,
                              color: controller.gender.value == Gender.male
                                  ? Colors.white
                                  : Colors.black,
                              size: 15.sp,
                            ),
                            Text(
                              'Male',
                              style: TextStyle(
                                color: controller.gender.value == Gender.male
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Obx(
                  () => Material(
                    color: controller.gender.value == Gender.male
                        ? Colors.white
                        : Colors.black,
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20.r),
                      onTap: () => controller.changeGenderToFemale(),
                      child: Container(
                        width: 80.w,
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 5.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              controller.gender.value == Gender.male
                                  ? Icons.brightness_1_outlined
                                  : Icons.brightness_1,
                              color: controller.gender.value == Gender.male
                                  ? Colors.black
                                  : Colors.white,
                              size: 15.sp,
                            ),
                            Text(
                              'Female',
                              style: TextStyle(
                                color: controller.gender.value == Gender.male
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget birthDate() {
      return Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Birth Date',
                style: TextStyle(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 15.sp,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: controller.birthDateController,
                readOnly: true,
                onTap: () => controller.changeDate(context),
                decoration:  InputDecoration(
                  contentPadding: REdgeInsets.all( 5),
                  isDense: true,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFB4B4B4),
                  )),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFB4B4B4),
                  )),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFB4B4B4), width: 2)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget phoneNumber() {
      return Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Phone',
                style: TextStyle(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 15.sp,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: controller.phoneController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  contentPadding: REdgeInsets.all( 5),
                  isDense: true,
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFB4B4B4),
                  )),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFB4B4B4),
                  )),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFB4B4B4), width: 2)),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget addressWithInput() {
      return Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Address',
                style: TextStyle(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 15.sp,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: controller.addressController,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                maxLines: 4,
                keyboardType: TextInputType.phone,
                decoration:  InputDecoration(
                  contentPadding: REdgeInsets.all( 5),
                  isDense: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFB4B4B4),
                  )),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFB4B4B4),
                  )),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFB4B4B4), width: 2)),
                ),
              ),
            )
          ],
        ),
      );
    }

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  'assets/images/user.png',
                  height: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.h),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    nameWithInput(),
                    genderWithCheck(),
                    birthDate(),
                    phoneNumber(),
                    addressWithInput(),
                    Padding(
                      padding: REdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                          onPressed: () => controller.savePersonalDetail(),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(60.r),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10).r),
                          ),
                          child: const Text('Save')),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
