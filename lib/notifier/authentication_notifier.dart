import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:team_manager/openapi/api.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/user_connected_service.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final String headerAuthorization = 'Authorization';
  final FirebaseAuthenticationService authenticationService = GetIt.I.get();
  final ApiClient apiClient = GetIt.I.get();
  final UserConnectedService userConnectedService = GetIt.I.get();
  final JwtControllerApi jwtControllerApi = GetIt.I.get();

  User? user;

  /// On écoute les changements d'authentification.
  /// A chaque changement on va rechercher le token et le setter
  /// comme header par défaut dans le apiClient.
  AuthenticationNotifier() {
    authenticationService.listenAuthChanges().listen((user) {
      this.user = user;
      setToken(this.user);
    });
  }

  void setToken(User? user) {
    if (user != null) {
      user.getIdToken(true).then((firebaseToken) => jwtControllerApi.jwt(firebaseToken)).then((jwt) {
        if (jwt != null) {
          setDefaultHeader(jwt);
          final Map<String, dynamic> map = JwtDecoder.decode(jwt);
          final TeammateDto teammateDto = TeammateDto(
            id: int.parse(map['jti']),
            email: map['sub'],
            nom: map['nom'],
            prenom: map['prenom'],
            telephone: map['telephone'],
          );
          userConnectedService.setUser(teammateDto);
          notifyListeners();
        }
      }).catchError((error) => print('Erreur ' + error));
    } else {
      apiClient.defaultHeaderMap.update(headerAuthorization, (value) => '');
    }
  }

  void setDefaultHeader(String? token) {
    if (token != null) {
      if (apiClient.defaultHeaderMap.containsKey(headerAuthorization)) {
        apiClient.defaultHeaderMap[headerAuthorization] = 'Bearer $token';
      } else {
        apiClient.addDefaultHeader(headerAuthorization, 'Bearer $token');
      }
    } else {
      apiClient.defaultHeaderMap.update(headerAuthorization, (value) => '');
    }
  }
}
