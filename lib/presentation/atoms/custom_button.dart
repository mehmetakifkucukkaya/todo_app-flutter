import 'package:flutter/material.dart';

import '../../config/themes/app_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
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
