import 'package:client/pages/common/splash_screen.dart';
import 'package:client/pages/common/unknown.dart';
import 'package:client/pages/setting/setting.dart';
import 'package:flutter/services.dart';
import 'package:client/pages/auth/login_screen.dart';
import 'package:client/pages/auth/login_signup_screen.dart';
import 'package:client/pages/auth/signup_screen.dart';
import 'package:client/pages/get_start/get_started_one_screen.dart';
import 'package:client/pages/get_start/get_started_two_screen.dart';
import 'package:client/pages/get_start/on_boarding_screen.dart';
import 'package:client/pages/home_page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorSchemeSeed: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
            useMaterial3: true,
          ),
          unknownRoute: GetPage(name: '/notfound', page: () => const Unknown()),
          getPages: [
            GetPage(
                name: '/auth',
                page: () => const LoginSignupScreen(),
                transition: Transition.rightToLeft),
            GetPage(
                name: '/login',
                page: () => const LoginScreen(),
                transition: Transition.rightToLeft),
            GetPage(
                name: '/signup',
                page: () => const SignupScreen(),
                transition: Transition.rightToLeft),
            GetPage(name: '/home', page: () => const HomeScreen()),
            GetPage(name: '/setting', page: () => const Setting()),
          ],
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      // child: const Setting(),
      child: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (
          (context, snapshot) =>
              snapshot.connectionState != ConnectionState.done
                  ? const SplashScreen()
                  : const OnBoardingScreen()
        ),
      ),
    );
  }
}
