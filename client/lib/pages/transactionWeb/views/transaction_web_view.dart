import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/transaction_web_controller.dart';

class TransactionWebView extends GetView<TransactionWebController> {
  const TransactionWebView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.goBack();
        return false;
      },
      child: Scaffold(
        body: WebViewWidget(
          controller: controller.webController,
        ),
      ),
    );
  }
}
