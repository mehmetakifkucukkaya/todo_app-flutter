// ignore_for_file: public_member_api_docs

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/bindings/auth_binding.dart';
import 'package:todo_app/config/routes/app_pages.dart';
import 'package:todo_app/controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      themeMode: ThemeMode.system,
      initialRoute: AppPages.INITIAL,
      initialBinding: AuthBinding(),
      getPages: AppPages.routes,
    );
  }
}
