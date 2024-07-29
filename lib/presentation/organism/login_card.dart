// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes/app_pages.dart';
import 'package:todo_app/config/themes/app_theme.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/presentation/molecules/auth/login_form.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    required this.loginForm,
    super.key,
  });
  final LoginForm loginForm;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            loginForm,
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppStrings.dontHaveAccount,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.REGISTER),
                  child: const Text(
                    AppStrings.register,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blueText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
