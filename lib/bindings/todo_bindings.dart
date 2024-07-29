// ignore_for_file: public_member_api_docs

import 'package:get/get.dart';

import 'package:todo_app/controllers/todo_controller.dart';

class TodoBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController());
  }
}
