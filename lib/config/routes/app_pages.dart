import 'package:get/get.dart';
import 'package:todo_app/presentation/views/auth/register_page.dart';

import '../../bindings/auth_binding.dart';
import '../../bindings/todo_bindings.dart';
import '../../presentation/views/auth/login_page.dart';
import '../../presentation/views/home_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
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
