import 'package:firebase_auth/firebase_auth.dart';

class UserConnectedService {
  User? user;

  setUser(User? user) {
    this.user = user;
  }

  User? getUser() {
    return user;
  }
}
