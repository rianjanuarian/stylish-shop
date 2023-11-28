import 'package:get/get.dart';

import '../pages/auth/login/bindings/login_binding.dart';
import '../pages/auth/login/views/login_view.dart';
import '../pages/auth/login_signup_screen.dart';
import '../pages/auth/signup/bindings/signup_binding.dart';
import '../pages/auth/signup/views/signup_view.dart';
import '../pages/cart/bindings/cart_binding.dart';
import '../pages/cart/views/cart_view.dart';
import '../pages/categories/categories/bindings/categories_binding.dart';
import '../pages/categories/categories/views/categories_view.dart';
import '../pages/categories/detailCategory/bindings/detail_category_binding.dart';
import '../pages/categories/detailCategory/views/detail_category_view.dart';
import '../pages/common/unknown.dart';
import '../pages/get_start/on_boarding_screen.dart';
import '../pages/get_start/splash_screen/bindings/splash_screen_binding.dart';
import '../pages/get_start/splash_screen/views/splash_screen_view.dart';
import '../pages/home_page/detail_product/bindings/detail_product_binding.dart';
import '../pages/home_page/detail_product/views/detail_product_view.dart';
import '../pages/home_page/home_screen/bindings/home_screen_binding.dart';
import '../pages/home_page/home_screen/views/home_screen_view.dart';
import '../pages/home_page/new_arrival/bindings/new_arrival_binding.dart';
import '../pages/home_page/new_arrival/views/new_arrival_view.dart';
import '../pages/main_tab/bindings/main_tab_binding.dart';
import '../pages/main_tab/views/main_tab_view.dart';
import '../pages/profile/change_password/bindings/change_password_binding.dart';
import '../pages/profile/change_password/views/change_password_view.dart';
import '../pages/profile/order_ongoing/bindings/order_ongoing_binding.dart';
import '../pages/profile/order_ongoing/views/order_ongoing_view.dart';
import '../pages/profile/others/about_service.dart';
import '../pages/profile/others/privacy_policy.dart';
import '../pages/profile/others/term_condition.dart';
import '../pages/profile/personal_detail/bindings/personal_detail_binding.dart';
import '../pages/profile/personal_detail/views/personal_detail_view.dart';
import '../pages/profile/setting/bindings/setting_binding.dart';
import '../pages/profile/setting/views/setting_view.dart';
import '../pages/search_page/bindings/search_page_binding.dart';
import '../pages/search_page/views/search_page_view.dart';
import '../pages/transaction/bindings/place_order_binding.dart';
import '../pages/transaction/views/place_order_view.dart';
import '../pages/transactionWeb/bindings/transaction_web_binding.dart';
import '../pages/transactionWeb/views/transaction_web_view.dart';

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
  static const categories = '/categories';
  static const search = '/search';
  static const cart = '/cart';
  static const detail = '/detail';
  static const placeOrder = '/place-order';
  static const detailCategory = '/detail-category';
  static const transactionWebView = '/transaction-webview';

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
      page: () => const MainTabView(),
      binding: MainTabBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: newArrival,
      page: () => const NewArrivalView(),
      binding: NewArrivalBinding(),
    ),
    GetPage(
      name: setting,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: personalDetail,
      page: () => const PersonalDetailView(),
      binding: PersonalDetailBinding(),
    ),
    GetPage(
      name: orderOngoing,
      page: () => const OrderOngoingView(),
      binding: OrderOngoingBinding(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
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
    GetPage(
      name: categories,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: search,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: detail,
      page: () => const DetailProductView(),
      binding: DetailProductBinding(),
    ),
    GetPage(
      name: placeOrder,
      page: () => const PlaceOrderView(),
      binding: PlaceOrderBinding(),
    ),
    GetPage(
      name: detailCategory,
      page: () => const DetailCategoryView(),
      binding: DetailCategoryBinding(),
    ),
    GetPage(
      name: transactionWebView,
      page: () => const TransactionWebView(),
      binding: TransactionWebBinding(),
    ),
  ];
}
