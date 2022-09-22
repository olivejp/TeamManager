import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final FirebaseAuthenticationService authenticationService = GetIt.I.get();
  final ApiClient apiClient = GetIt.I.get();

  User? user;

  /// On écoute les changements d'authentification.
  /// A chaque changement on va rechercher le token et le setter
  /// comme header par défaut dans le apiClient.
  AuthenticationNotifier() {
    authenticationService.listenAuthChanges().listen((newUser) {
      user = newUser;
      setToken(user);
      notifyListeners();
    });
  }

  void setToken(User? user) {
    this.user = user;
    this.user?.getIdToken(true).then((token) {
      apiClient.addDefaultHeader('Authorization', 'Bearer $token');
    }).catchError((error) {
      print('Erreur');
    });
  }
}
