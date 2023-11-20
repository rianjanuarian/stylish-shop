import 'package:get/get.dart';
import '../pages/profile/setting/bindings/setting_binding.dart';
import '../pages/profile/setting/views/setting_view.dart';
import '../pages/auth/login_signup_screen.dart';
import '../pages/common/unknown.dart';
import '../pages/get_start/on_boarding_screen.dart';
import '../pages/home_page/home_screen.dart';
import '../pages/home_page/new_arrival.dart';
import '../pages/login/bindings/login_binding.dart';
import '../pages/login/views/login_view.dart';
import '../pages/main_tab/main_tab.dart';
import '../pages/profile/about_service.dart';
import '../pages/profile/change_password.dart';
import '../pages/profile/order_ongoing.dart';
import '../pages/profile/personal_details.dart';
import '../pages/profile/privacy_policy.dart';
import '../pages/profile/term_condition.dart';
import '../pages/signup/bindings/signup_binding.dart';
import '../pages/signup/views/signup_view.dart';
import '../pages/splash_screen/bindings/splash_screen_binding.dart';
import '../pages/splash_screen/views/splash_screen_view.dart';

class AppPages {
  static const splash = '/splash-screen';
  static const onBoarding = '/on-boarding';
  static const auth = '/auth';
  static const login = '/login';
  static const signup = '/signup';
  static const mainTab = '/main-tab';
  static const home = '/home';
  static const newArrival = '/new-arrival';
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
      page: () => const LoginView(),
      transition: Transition.rightToLeft,
      binding: LoginBinding(),
    ),
    GetPage(
      name: signup,
      page: () => const SignupView(),
      transition: Transition.rightToLeft,
      binding: SignupBinding(),
    ),
    GetPage(
      name: mainTab,
      page: () => const MainTab(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: newArrival,
      page: () => const NewArrival(),
    ),
    GetPage(
      name: setting,
      page: () => const SettingView(),
      binding: SettingBinding(),
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
