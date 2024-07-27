import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_strings.dart';
import '../../../controllers/auth_controller.dart';
import '../../molecules/auth/register_form.dart';

class RegisterPage extends GetView<AuthController> {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController =
      TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.register),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/icon.png",
                        height: constraints.maxHeight * 0.2,
                        width: constraints.maxWidth * 0.4,
                      ),
                      const SizedBox(height: 18),
                      Card(
                        color: Colors.white,
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RegisterForm(
                            formKey: _formKey,
                            emailController: emailController,
                            passwordController: passwordController,
                            firstNameController: firstNameController,
                            lastNameController: lastNameController,
                            onRegister: () {
                              if (_formKey.currentState!.validate()) {
                                controller.register(
                                  emailController.text,
                                  passwordController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
