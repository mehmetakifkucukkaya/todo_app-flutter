import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../viewmodel/auth_controller.dart';

class RegisterPage extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.register)),
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
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                controller.register(
                    emailController.text, passwordController.text);
              },
              child: const Text(AppStrings.register),
            ),
          ],
        ),
      ),
    );
  }
}
