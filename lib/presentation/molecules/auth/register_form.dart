// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/core/validators/register_validator.dart';
import 'package:todo_app/presentation/atoms/custom_button.dart';
import 'package:todo_app/presentation/atoms/custom_text_field.dart';

class RegisterForm extends StatelessWidget {

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.onRegister,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: firstNameController,
            labelText: AppStrings.name,
            validator: Validators.validateName,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: lastNameController,
            labelText: AppStrings.lastName,
            validator: Validators.validateLastName,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: emailController,
            labelText: AppStrings.email,
            validator: Validators.validateEmail,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: passwordController,
            labelText: AppStrings.password,
            obscureText: true,
            validator: Validators.validatePassword,
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: onRegister,
            text: AppStrings.register,
          ),
        
        ],
      ),
    );
  }
}
