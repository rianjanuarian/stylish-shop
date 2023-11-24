import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../services/api_service/user/user_service_models.dart';

enum Gender { male, female }

class PersonalDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  Rx<Gender> gender = Gender.male.obs;
  late final TextEditingController birthDateController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  UserModel? user;

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
      } catch (e) {
        if (e is DioException) {
          final errorResponse = e.response;
          if (errorResponse != null) {
            final errorMessage = errorResponse.data?['message'];
            Get.snackbar('Error', errorMessage ?? 'Unknown error');
          } else {
            Get.snackbar('Error', 'Unknown error occurred');
          }
          isLoading.toggle();
        }
      }
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    birthDateController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
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
