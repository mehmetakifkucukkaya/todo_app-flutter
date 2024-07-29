// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

// Uygulamada kullanılacak ikon widgetım
class AppIcon extends StatelessWidget {

  const AppIcon({
    super.key,
    this.height = 150.0,
    this.width = 150.0,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/icon.png',
      height: height,
      width: width,
    );
  }
}
