// ignore_for_file: public_member_api_docs

import 'package:get/get.dart';

import 'package:todo_app/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
