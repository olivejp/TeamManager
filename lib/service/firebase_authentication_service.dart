import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  Stream<User?> listenAuthChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }
}
