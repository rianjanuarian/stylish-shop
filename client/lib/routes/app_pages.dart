import 'package:get/get.dart';

import '../pages/auth/login_screen.dart';
import '../pages/auth/login_signup_screen.dart';
import '../pages/auth/signup_screen.dart';
import '../pages/common/unknown.dart';
import '../pages/get_start/on_boarding_screen.dart';
import '../pages/home_page/home_screen.dart';
import '../pages/setting/setting.dart';
import '../pages/splash_screen/bindings/splash_screen_binding.dart';
import '../pages/splash_screen/views/splash_screen_view.dart';

class AppPages {
  static const splash = '/splash-screen';
  static const onBoarding = '/on-boarding';
  static const auth = '/auth';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const setting = '/setting';

  // Unknown
  static const unknown = '/unknown';

  static final unknownRoutes = [
    GetPage(
      name: unknown,
      page: () => const Unknown(),
    ),
  ];

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: onBoarding,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: auth,
      page: () => const LoginSignupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: signup,
      page: () => const SignupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: setting,
      page: () => const Setting(),
    ),
  ];
}
