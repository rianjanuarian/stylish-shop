import 'dart:ui';

import 'package:stylish_shop/routes/app_pages.dart';
import 'package:stylish_shop/services/keys/get_storage_key.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TransactionWebController extends GetxController {
  late WebViewController webController = WebViewController();

  final dio = Dio();
  final storage = GetStorage();

  @override
  void onInit() {
    final urlFromArgument = Get.arguments;
    //default bawaan dri https://pub.dev/packages/webview_flutter
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {
            if (url.contains('order_id') &&
                url.contains('transaction_status=settlement')) {
              final Uri uri = Uri.parse(url);
              String? id = uri.queryParameters['order_id'];
              String? status = uri.queryParameters['transaction_status'];
              final token = storage.read(GetStorageKey.token);
              try {
                final res = await dio
                    .get('https://stylish-shop.vercel.app/transactions/approve',
                        options: Options(headers: {
                          'Authorization': 'Bearer $token',
                          'Content-Type': 'application/json',
                        }),
                        queryParameters: {
                      'order_id': id,
                      'transaction_status': status,
                    });
                Get.snackbar('Payment Success',
                    'Your transaction payment has been successfully received and ${res.data['message']}');
                Get.offAllNamed(AppPages.mainTab);
              } catch (e) {
                if (e is DioException) {
                  final errorResponse = e.response;
                  if (errorResponse != null) {
                    if (errorResponse.data is Map) {
                      final errorMessage = errorResponse.data['message'];
                      Get.snackbar('Error', errorMessage ?? 'Unknown error');
                    } else {
                      Get.snackbar('Error', 'Unknown error occurred');
                    }
                  } else {
                    Get.snackbar('Error', e.toString());
                  }
                }
              }
            }
            // error gmana?
            if (url.contains('transaction_status=deny')) {
              Get.snackbar('Failed',
                  'Your transaction has been failed. Please try again');
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(urlFromArgument));
    super.onInit();
  }
}
