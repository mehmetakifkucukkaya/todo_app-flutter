import 'package:todo_app/core/constants/app_strings.dart';

// Register Form'da kullanılacak validatorleri kapsayan sınıf

class Validators {
  //* İsim boş olamaz ve sadece harf içerebilir
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.nameRequired;
    }

    return null;
  }

  //* Soyisim boş olamaz
  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.lastNameRequired;
    }

    return null;
  }

//* E posta boş olamaz ve mail formatında olmalıdır
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(value)) {
      return AppStrings.validEmail;
    }
    return null;
  }

//* Şifre boş olamaz ve en az 8 karakter olmalıdır
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 8) {
      return AppStrings.passwordMinCharacter;
    }
    return null;
  }
}
