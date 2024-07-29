// ignore_for_file: public_member_api_docs, always_put_required_named_parameters_first

import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/core/validators/register_validator.dart';
import 'package:todo_app/presentation/atoms/custom_button.dart';
import 'package:todo_app/presentation/atoms/textfield_login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      widget.onLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginTextField(
            controller: widget.emailController,
            labelText: AppStrings.email,
            prefixIcon: Icons.email,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          LoginTextField(
            controller: widget.passwordController,
            labelText: AppStrings.password,
            prefixIcon: Icons.lock,
            obscureText: true,
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: _handleLogin,
            text: AppStrings.login,
          ),
        ],
      ),
    );
  }
}
