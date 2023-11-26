import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../services/api_service/user/user_service_models.dart';
import '../../../../services/keys/get_storage_key.dart';

enum Gender { male, female }

class PersonalDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  Rx<Gender> gender = Gender.male.obs;
  late final TextEditingController birthDateController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  final ImagePicker imagePicker = ImagePicker();
  Rx<XFile?> image = Rx<XFile?>(null);
  final dio = Dio();
  final storage = GetStorage();
  RxBool isLoading = RxBool(false);

  String? formatDate(DateTime? date) {
    if (date == null) return null;

    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  void changeGenderToMale() {
    gender.value = Gender.male;
  }

  void changeGenderToFemale() {
    gender.value = Gender.female;
  }

  void changeDate(ctx) async {
    DateTime? pickedDate = await showDatePicker(
        context: ctx,
        initialDate: DateTime(2023, 1, 1),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      birthDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  void savePersonalDetail() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.toggle();
        //save personal details
        FormData formData = FormData();

        if (nameController.text.trim().isNotEmpty) {
          formData.fields.add(MapEntry('name', nameController.text.trim()));
        }

        if (birthDateController.text.trim().isNotEmpty) {
          formData.fields
              .add(MapEntry('birthday', birthDateController.text.trim()));
        }

        if (addressController.text.trim().isNotEmpty) {
          formData.fields
              .add(MapEntry('address', addressController.text.trim()));
        }

        if (phoneController.text.trim().isNotEmpty) {
          formData.fields
              .add(MapEntry('phone_number', phoneController.text.trim()));
        }

        if (image.value != null) {
          String fileName = File(image.value!.path).uri.pathSegments.last;
          formData.files.add(MapEntry(
            'image',
            await MultipartFile.fromFile(
              image.value!.path,
              filename: fileName,
            ),
          ));
        }

        formData.fields.add(MapEntry('gender', gender.value.name));

        print(formData.files);

        final token = await storage.read(GetStorageKey.token);
        await dio.put(
          "https://stylish-shop.vercel.app/users/update",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }),
          data: formData,
        );
      } catch (e) {
        if (e is DioException) {
          final errorResponse = e.response;
          if (errorResponse != null) {
            print(errorResponse);
            final errorMessage = errorResponse.data?['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
        } else {
          debugPrint('Unexpected error: $e');
          Get.snackbar('Error', 'An unexpected error occurred');
        }
      } finally {
        isLoading.toggle();
      }
    }
  }

  void takePicture(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SizedBox(
          width: double.infinity,
          height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Select Source'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: takePictureUsingCamera,
                    child: Column(
                      children: [
                        //ganti2 je la
                        Icon(
                          Icons.camera,
                          size: 50.sp,
                        ),
                        const Text('Camera'),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: takePictureUsingGallery,
                    child: Column(
                      children: [
                        //ganti2 je la
                        Icon(
                          Icons.browse_gallery,
                          size: 50.sp,
                        ),
                        const Text('Gallery'),
                      ],
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

  void takePictureUsingCamera() async {
    try {
      image.value = await imagePicker.pickImage(source: ImageSource.camera);
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  void takePictureUsingGallery() async {
    try {
      image.value = await imagePicker.pickImage(source: ImageSource.gallery);
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initializeController() async {
    user = Get.arguments;

    nameController = TextEditingController();
    birthDateController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    nameController.text = user.value?.name ?? '';
    gender.value = user.value?.gender == 'woman' ? Gender.female : Gender.male;
    birthDateController.text = formatDate(user.value?.birthday) ?? '';
    phoneController.text = user.value?.phone_number ?? '';
    addressController.text = user.value?.address ?? '';
  }

  @override
  void onInit() {
    initializeController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
