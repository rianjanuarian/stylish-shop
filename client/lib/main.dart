import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stylish_shop/routes/app_pages.dart';
import 'package:stylish_shop/themes/fonts.dart';

import 'services/storage_service/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyC5zv7y30pJU6i80SutR-vFiuyIallnTXI',
    appId: '1:648705838513:android:ba1224299a7056d5f7c190',
    messagingSenderId: '648705838513',
    projectId: 'stylishshop-562a7',
    storageBucket: 'stylishshop-562a7.appspot.com',
  ));
  await initialConfig();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Stylish Shop',
          theme: ThemeData(
            colorSchemeSeed: Colors.white,
            fontFamily: FontFamily.poppins,
            useMaterial3: true,
          ),
          initialRoute: AppPages.splash,
          unknownRoute: AppPages.unknownRoutes.first,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

Future<void> initialConfig() async {
  await Get.putAsync(() => StorageService().init());
}
