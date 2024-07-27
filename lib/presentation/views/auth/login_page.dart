import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/app_pages.dart';
import '../../../core/constants/app_strings.dart';
import '../../../viewmodel/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.login)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: AppStrings.email),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration:
                  const InputDecoration(labelText: AppStrings.password),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                controller.signIn(
                    emailController.text, passwordController.text);
              },
              child: const Text(AppStrings.login),
            ),
            TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: const Text(AppStrings.register),
            ),
          ],
        ),
      ),
    );
  }
}


//! Firebase Çalışıyor. Griş yapa kısmı sıkıntılı