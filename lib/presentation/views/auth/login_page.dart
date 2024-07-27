import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../viewmodel/auth_controller.dart';
import '../../atoms/app_icon.dart';
import '../../molecules/auth/login_form.dart';
import '../../organism/login_Card.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: 400,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppIcon(),
                      const SizedBox(height: 32),
                      LoginCard(
                        loginForm: LoginForm(
                          emailController: emailController,
                          passwordController: passwordController,
                          onLogin: () {
                            controller.signIn(
                              emailController.text,
                              passwordController.text,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
