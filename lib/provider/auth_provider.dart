import 'package:e_belediyecilik/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_belediyecilik/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final authService = AuthService(); // auth servise erişelim

  UserModel user = UserModel();
// email ve parola ile giriş yap
  Future register(String name, String email, String password) async {
    try {
      return authService.register(name, email, password);
    } catch (e) {
      print(e.toString());
    }
  }

  // google ile giriş yap

  Future<User?> registerWithGoogle() async {
    try {
      return await authService.registerWithGoogle();
    } catch (e) {
      print("Google ile Girişte bir hata var: $e");
      return null; // Hata durumunda null döndür
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    try {
      return await authService.loginWithEmail(email, password);
    } catch (e) {
      print("login işlemminde hatan var hata mesajı : $e");
      return null;
    }
  }
}
