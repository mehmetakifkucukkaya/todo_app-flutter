// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/config/routes/app_pages.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Get.offNamed(Routes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/animations/todo_animation.json',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
