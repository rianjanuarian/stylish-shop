import 'package:client/pages/auth/login_screen.dart';
import 'package:client/pages/auth/login_signup_screen.dart';
import 'package:client/pages/auth/signup_screen.dart';
import 'package:client/pages/get_start/get_started_one_screen.dart';
import 'package:client/pages/get_start/get_started_two_screen.dart';
import 'package:client/pages/get_start/on_boarding_screen.dart';
import 'package:client/pages/home_page/dashboard_screen.dart';
// import 'package:client/pages/get_start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorSchemeSeed: Colors.white,
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        // home: FutureBuilder(
        //   future: Future.delayed(const Duration(seconds: 3)),
        //   builder: (
        //     (context, snapshot) =>
        //         snapshot.connectionState != ConnectionState.done
        //             ? const SplashScreen()
        //             : const GetStartedOne()
        //   ),
        // ),
        home: const DasboardScreen());
  }
}
