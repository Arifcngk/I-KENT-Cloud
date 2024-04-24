import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> register(String email, String password) async {
    var credentinal = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentinal.user;
  }

  Future<User?> registerWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    var account = await googleSignIn.signIn();

    if (account != null) {
      var auth = await account.authentication;
      if (auth.accessToken != null && auth.idToken != null) {
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: auth.idToken, accessToken: auth.accessToken);

        var userCredantial = await _auth.signInWithCredential(credential);
        return userCredantial.user;
      }
    }
  }

  Future<User?> loginWithEmail(String email, String password) async {
    var credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }
}
