import 'package:get/get.dart';
import 'package:machine_test_norq/app/modules/login/bindings/login_binding.dart';
import 'package:machine_test_norq/app/modules/login/views/login_view.dart';
import 'package:machine_test_norq/app/modules/cart/bindings/cart_binding.dart';
import 'package:machine_test_norq/app/modules/cart/views/cart_view.dart';
import 'package:machine_test_norq/app/modules/details/bindings/details_binding.dart';
import 'package:machine_test_norq/app/modules/details/views/details_view.dart';
import 'package:machine_test_norq/app/modules/home/bindings/home_binding.dart';
import 'package:machine_test_norq/app/modules/home/views/home_view.dart';
import 'package:machine_test_norq/app/modules/signup/bindings/signup_binding.dart';
import 'package:machine_test_norq/app/modules/signup/views/signup_view.dart';
import 'package:machine_test_norq/app/modules/splash/bindings/splash_binding.dart';
import 'package:machine_test_norq/app/modules/splash/views/splash_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.details,
      page: () => const DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.cart,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
  ];
}
