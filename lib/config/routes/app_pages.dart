// ignore_for_file: public_member_api_docs

import 'package:get/get.dart';
import 'package:todo_app/bindings/auth_binding.dart';
import 'package:todo_app/bindings/todo_bindings.dart';
import 'package:todo_app/presentation/views/auth/login_page.dart';
import 'package:todo_app/presentation/views/auth/register_page.dart';
import 'package:todo_app/presentation/views/home_page.dart';
import 'package:todo_app/presentation/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: TodoBinding(),
    ),
  ];
}
