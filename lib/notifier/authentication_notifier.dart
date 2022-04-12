import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final FirebaseAuthenticationService authenticationService = GetIt.I.get();
  User? user;

  AuthenticationNotifier() {
    authenticationService.listenAuthChanges().listen((newUser) {
      user = newUser;
      notifyListeners();
    });
  }

}
