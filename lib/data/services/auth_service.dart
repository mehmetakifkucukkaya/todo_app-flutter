// ignore_for_file: noop_primitive_operations, public_member_api_docs

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password,);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //* Kayıt olma metodu
  Future<User?> register(String email, String password, String firstName,
      String lastName,) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password,);
      final user = result.user;

      // Anlık tarih verisini alıp oluşturulma tarihini belirliyoruuz
      final now = DateTime.now();

      // Kullanıcı bilgilerini Firestore'a kaydediyoruz
      await _firestore.collection('users').doc(user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'createdAt': Timestamp.fromDate(now),
      });

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //* Çıkış yapma metodu
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
