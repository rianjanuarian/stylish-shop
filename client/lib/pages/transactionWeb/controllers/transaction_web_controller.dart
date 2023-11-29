import 'dart:ui';

import 'package:client/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TransactionWebController extends GetxController {
  late WebViewController webController = WebViewController();

  final dio = Dio();

  @override
  void onInit() {
    final url = Get.arguments;
    final Uri uri = Uri.parse(url);
    String? id = uri.queryParameters['id'];
    String? status = uri.queryParameters['transaction_status'];
    //default bawaan dri https://pub.dev/packages/webview_flutter
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {
            if (url.contains('status_code=200&transaction_status=settlement')) {
              final res = await dio.get(
                  'https://stylish-shop.vercel.app/transactions/approve',
                  queryParameters: {
                    'order_id': id,
                    'transaction_status': status,
                  });
              Get.snackbar('Payment Success',
                  'Your transaction payment has been successfully received and ${res.data['message']}');
              Get.offAllNamed(AppPages.mainTab);
            }
            if (url.contains('status_code=202&transaction_status=deny')) {
              //jam 1 ga ada ide klo gagal ngapain
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
      ..loadRequest(Uri.parse(url));
    super.onInit();
  }
}