import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    var credentinal = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentinal.user;
  }
}
