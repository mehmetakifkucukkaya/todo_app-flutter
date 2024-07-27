import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/themes/app_theme.dart';

import '../../config/routes/app_pages.dart';
import '../../core/constants/app_strings.dart';
import '../molecules/auth/login_form.dart';

class LoginCard extends StatelessWidget {
  final LoginForm loginForm;

  const LoginCard({
    super.key,
    required this.loginForm,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[50],
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
