import 'dart:convert';

import 'package:client/models/products.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productList = <Products>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    const String url = "http://192.168.0.104:3000/products";
    try {
      final response = await Dio().get(
        url,
      );

      if (response.statusCode == 200) {
        final List<dynamic> result = response.data;
        print(result);
        productList.value = result.map((e) => Products.fromJson(e)).toList();
        isLoading.value = false;

        update();
      } else {
        Get.snackbar('error fetching data', 'error : ${response.statusCode.toString()}');
    
      }
    } catch (e) {
      print(e);
    }
  }
}

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// import 'package:getx_demo/model/user_model.dart';

// class UserController extends GetxController {
//   var userList = <UserModel>[].obs;
//   var isLoading = true.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getUsers();
//   }

//   Future<void> getUsers() async {
//     const String userUrl = "https://reqres.in/api/users?page=2";
//     final response = await http.get(Uri.parse(userUrl));
//     if (response.statusCode == 200) {
//       final List result = jsonDecode(response.body)['data'];
//       userList.value = result.map((e) => UserModel.fromJson(e)).toList();
//       isLoading.value = false;
//       update();
//     } else {
//       Get.snackbar('Error Loading data!',
//           'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
//     }
//   }
// }