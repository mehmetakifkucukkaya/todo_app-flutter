// Uygulamada kullanılacak olan metinleri içeren sınıf

class AppStrings {
  // Genel Metinler
  static const String appName = "ToDo App";
  static const String todo = "ToDo";
  static const String dontHaveAccount = "Hesabınız yok mu?";
  static const String haveAccount = "Hesabınız var mı?";

  // Görevler ile ilgili metinler
  static const String addTodo = "Görev Ekle";
  static const String deleteTodo = "Görev Sil";
  static const String updateTodo = "Görev Güncelle";
  static const String completeTodo = "Görev'i Tamamla";
  static const String notTodoYet = "Henüz Eklenmiş Görev Yok!";

  // Login İle ilgili metinler
  static const String login = "Giriş Yap";
  static const String register = "Kayıt Ol";
  static const String logout = "Çıkış Yap";

  // Input Alanları İle İlgili Metinler
  static const String email = "E-posta";
  static const String password = "Şifre";
  static const String name = "İsim";
  static const String lastName = "Soy İsim";

  // Tablar İle İlgili Metinler
  static const String completedTodos = "Tamamlanmış";
  static const String notCompletedTodos = "Tamamlanmamış";

  // Validation İle İlgili Metinler //

  // İsim
  static const String nameRequired = "İsim alanı boş bırakılamaz";
  // Soyisim
  static const String lastNameRequired = "Soyisim alanı boş bırakılamaz";

  // E-posta
  static const String emailRequired = "E-Posta alanı boş bırakılamaz";
  static const String validEmail = "Geçerli bir e-posta adresi giriniz";

  // Şifre
  static const String passwordRequired = "Şifre alanı boş bırakılamaz";

  static const String passwordMinCharacter =
      "Şifreniz en az 8 karakter olmalıdır";
}
