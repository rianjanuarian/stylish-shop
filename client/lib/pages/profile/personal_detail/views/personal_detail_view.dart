import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
                  contentPadding: REdgeInsets.all(5),
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
                decoration: InputDecoration(
                  contentPadding: REdgeInsets.all(5),
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
                decoration: InputDecoration(
                  contentPadding: REdgeInsets.all(5),
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

    void takePicture(BuildContext context) async {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SizedBox(
            width: double.infinity,
            height: 200.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Choose',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: controller.takePictureUsingCamera,
                      borderRadius: BorderRadius.circular(15).r,
                      child: SizedBox(
                        height: 100.h,
                        width: 80.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //ganti2 je la
                            Icon(
                              Icons.camera,
                              size: 50.sp,
                            ),
                            const Text('Camera',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: controller.takePictureUsingGallery,
                      borderRadius: BorderRadius.circular(15).r,
                      child: SizedBox(
                        height: 100.h,
                        width: 80.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //ganti2 je la
                            Icon(
                              Icons.photo_library,
                              size: 50.sp,
                            ),
                            const Text('Gallery',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: controller.image.value != null
                            ? Image.file(
                                File(controller.image.value!.path),
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: (controller.user.value?.image ?? '')
                                        .contains('placeholder')
                                    ? controller.user.value?.image ??
                                        "https://via.placeholder.com/200"
                                    : 'https://storage.googleapis.com/${controller.user.value?.image}',
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ),
                    ),
                    //meh seadanya dulu
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: Material(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                          //fungsi ambil gambar
                          onTap: () => takePicture(context),
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            height: 30.h,
                            width: 30.h,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
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
                        child: Obx(
                          () => ElevatedButton(
                              onPressed: controller.isLoading.isTrue
                                  ? null
                                  : () => controller.savePersonalDetail(),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(60.r),
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10).r),
                              ),
                              child: controller.isLoading.isTrue
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text('Save')),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
