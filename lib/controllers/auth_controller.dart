// ignore_for_file: public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_app/config/routes/app_pages.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/data/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  String? get userId => firebaseUser.value?.uid;

  void _setInitialScreen(User? user) {
    if (user == null) {
      print('No user logged in');
    } else {
      print('User logged in: ${user.uid} - ${user.email}');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      Get.offAllNamed(Routes.HOME);
      print('User signed in ');
    } catch (e) {
      Get.snackbar(AppStrings.error, e.toString());
    }
  }

  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    final user =
        await _authService.register(email, password, firstName, lastName);
    if (user != null) {
      Get.offAllNamed('/login');
    } else {
      Get.snackbar(AppStrings.error, 'Registration failed');
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
