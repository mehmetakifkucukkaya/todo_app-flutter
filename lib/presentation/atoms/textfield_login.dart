// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    super.key,
    this.obscureText = false,
    this.validator,
  });
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(prefixIcon),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
