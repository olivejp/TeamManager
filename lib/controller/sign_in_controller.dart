import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';

class SignInController {
  final FirebaseAuthenticationService service = GetIt.I.get();
  String? _email;
  String? _password;
  String? error;

  void setEmail(String? email) {
    _email = email;
  }

  void setPassword(String? password) {
    _password = password;
  }

  void setError(String? newError) {
    error = newError;
  }

  Future<UserCredential> onPressEnter(GlobalKey<FormState> formKey) {
    if (_email == null) {
      return Future<UserCredential>.error("L'email ne peut pas être null.");
    }

    if (_password == null) {
      return Future<UserCredential>.error("Le mot de passe ne peut pas être null.");
    }

    if (formKey.currentState?.validate() == true) {
      return service.signInWithEmailPassword(_email!, _password!).catchError((Object? error) {
        setError(error.toString());
      });
    } else {
      return Future<UserCredential>.error("Le formulaire n'est pas valide.");
    }
  }
}
