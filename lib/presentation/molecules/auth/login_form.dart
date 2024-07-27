import 'package:flutter/material.dart';
import 'package:todo_app/presentation/atoms/textfield_login.dart';

import '../../../core/constants/app_strings.dart';
import '../../atoms/custom_button.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginTextField(
          controller: emailController,
          labelText: AppStrings.email,
          prefixIcon: Icons.email,
        ),
        const SizedBox(height: 16),
        LoginTextField(
          controller: passwordController,
          labelText: AppStrings.password,
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 24),
        CustomButton(
          onPressed: onLogin,
          text: AppStrings.login,
        ),
      ],
    );
  }
}
