// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/presentation/atoms/app_icon.dart';
import 'package:todo_app/presentation/molecules/auth/login_form.dart';
import 'package:todo_app/presentation/organism/login_Card.dart';

class LoginPage extends GetView<AuthController> {
  LoginPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //* Responsive UI için
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
              maxWidth: 400,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(16),
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
        ),
      ),
    );
  }
}
