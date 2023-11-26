import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../services/api_service/user/user_service_models.dart';
import '../../../../services/keys/get_storage_key.dart';
import '../../setting/controllers/setting_controller.dart';

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
          DateTime pickedDate =
              DateFormat('dd-MM-yyyy').parse(birthDateController.text.trim());
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          formData.fields.add(MapEntry('birthday', formattedDate));
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
          List<int> imageBytes = await File(image.value!.path).readAsBytes();
          String fileName = File(image.value!.path).uri.pathSegments.last;
          MultipartFile imageFile = MultipartFile.fromBytes(
            imageBytes,
            filename: fileName,
          );
          formData.files.add(MapEntry('images', imageFile));
        }

        formData.fields.add(
            MapEntry('gender', gender.value.name == 'male' ? 'man' : 'woman'));

        final token = await storage.read(GetStorageKey.token);
        await dio.put(
          "https://stylish-shop.vercel.app/users/update",
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          }),
          data: formData,
        );
        await Get.find<SettingController>().getUser();
        Get.back();
      } catch (e) {
        if (e is DioException) {
          final errorResponse = e.response;
          if (errorResponse != null) {
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
