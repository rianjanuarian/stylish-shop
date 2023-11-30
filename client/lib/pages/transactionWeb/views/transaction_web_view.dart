import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/transaction_web_controller.dart';

class TransactionWebView extends GetView<TransactionWebController> {
  const TransactionWebView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80.w,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => controller.goBack(),
            style: IconButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.black),
          ),
          backgroundColor: const Color(0xFF002755),
        ),
        body: WebViewWidget(
          controller: controller.webController,
        ),
      ),
    );
  }
}
