import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../config/routes/app_pages.dart';
import '../data/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    user.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      Get.offAllNamed(Routes.HOME);
      print('User signed in');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.register(email, password);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void signOut() async {
    await _authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
