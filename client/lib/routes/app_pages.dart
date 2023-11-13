import 'package:client/pages/profile/about_service.dart';
import 'package:client/pages/profile/change_password.dart';
import 'package:client/pages/profile/order_ongoing.dart';
import 'package:client/pages/profile/personal_details.dart';
import 'package:client/pages/profile/privacy_policy.dart';
import 'package:client/pages/profile/setting.dart';
import 'package:client/pages/profile/term_condition.dart';
import 'package:get/get.dart';

import '../pages/auth/login_signup_screen.dart';
import '../pages/auth/signup_screen.dart';
import '../pages/common/unknown.dart';
import '../pages/get_start/on_boarding_screen.dart';
import '../pages/home_page/home_screen.dart';
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
  static const personalDetail = '/personal-detail';
  static const orderOngoing = '/order-ongoing';
  static const changePassword = '/change-password';
  static const aboutService = '/about-service';
  static const privacyPolicy = '/privacy-policy';
  static const termCondition = '/term-condition';

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
      binding: LoginBinding(),
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
    GetPage(
      name: personalDetail,
      page: () => const PersonalDetail(),
    ),
    GetPage(
      name: orderOngoing,
      page: () => const OrderOngoing(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePassword(),
    ),
    GetPage(
      name: privacyPolicy,
      page: () => const PrivacyPolicy(),
    ),
    GetPage(
      name: termCondition,
      page: () => const TermCondition(),
    ),
    GetPage(
      name: aboutService,
      page: () => const AboutService(),
    ),
  ];
}
