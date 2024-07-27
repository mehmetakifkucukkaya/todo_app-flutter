import 'package:flutter/material.dart';

// Uygulamada kullanılacak ikon widgetım
class AppIcon extends StatelessWidget {
  final double height;
  final double width;

  const AppIcon({
    super.key,
    this.height = 150.0,
    this.width = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/icon.png",
      height: height,
      width: width,
    );
  }
}
