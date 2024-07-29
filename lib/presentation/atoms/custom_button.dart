// ignore_for_file: public_member_api_docs, always_put_required_named_parameters_first

import 'package:flutter/material.dart';

import 'package:todo_app/config/themes/app_theme.dart';

class CustomButton extends StatelessWidget {

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppTheme.buttonColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: AppTheme.buttonText,
        ),
      ),
    );
  }
}
