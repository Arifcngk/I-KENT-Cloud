import 'package:e_belediyecilik/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_belediyecilik/services/auth_service.dart';
class AuthProvider extends ChangeNotifier {
  final authService = AuthService(); // auth servise erişelim

  UserModel user = UserModel();

  Future register(String email, String password) async {
    try {
      return authService.register(email, password);
    } catch (e) {
      print(e.toString());
    }
  }
}
