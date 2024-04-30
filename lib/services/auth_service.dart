import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> register(
      String displayName, String email, String password) async {
    var credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Yeni kullanıcı oluşturulduğunda Firestore'a kullanıcı bilgilerini kaydet
    if (credential.user != null) {
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'displayName': displayName,
        'email': email,
      });
    }

    return credential.user;
  }

  Future<User?> registerWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    var account = await googleSignIn.signIn();

    if (account != null) {
      var auth = await account.authentication;
      if (auth.accessToken != null && auth.idToken != null) {
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: auth.idToken, accessToken: auth.accessToken);

        var userCredential = await _auth.signInWithCredential(credential);

        // Google hesabıyla oturum açıldığında Firestore'a kullanıcı bilgilerini kaydet
        if (userCredential.user != null) {
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'displayName': userCredential.user!.displayName,
            'email': userCredential.user!.email,
          });
        }

        return userCredential.user;
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
