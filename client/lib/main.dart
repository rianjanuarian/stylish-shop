import 'package:client/routes/app_pages.dart';
import 'package:client/services/storage_service/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            fontFamily: 'Poppins',
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
