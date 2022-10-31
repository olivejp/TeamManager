import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';
import 'package:team_manager/openapi/api.dart';

class FirebaseAuthenticationService {
  final ApiClient apiClient = GetIt.I.get();
  final JwtControllerApi jwtControllerApi = GetIt.I.get();
  final String headerAuthorization = 'Authorization';
  final BehaviorSubject<bool> _isAuthenticatedSub = BehaviorSubject.seeded(false);
  final BehaviorSubject<TeammateDto?> _teammateConnectedSub = BehaviorSubject.seeded(null);

  FirebaseAuthenticationService() {
    print('FirebaseAuthenticationService constructor');
    _listenAuthChanges().listen((userOrNull) {
      if (userOrNull != null) {
        _isAuthenticatedSub.sink.add(true);
        setToken(FirebaseAuth.instance.currentUser!);
      } else {
        _isAuthenticatedSub.sink.add(false);
        setToken(null);
      }
    });
  }

  Stream<TeammateDto?> teammateConnectedStr() {
    return _teammateConnectedSub.stream;
  }

  Stream<bool> isAuthenticatedStr() {
    return _isAuthenticatedSub.stream;
  }

  bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Stream<User?> _listenAuthChanges() {
    print('listenAuthChanges');
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) {
    print('signInWithEmailPassword');
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    print('signOut');
    return FirebaseAuth.instance.signOut();
  }

  Future<void> forgotPassword(String email) {
    print('forgotPassword');
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> setToken(User? user) async {
    print('setToken $user');
    if (user != null) {
      var firebaseToken = await user.getIdToken(true);
      var jwt = await jwtControllerApi.jwt(firebaseToken);
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
        _teammateConnectedSub.sink.add(teammateDto);
      }
    } else {
      apiClient.defaultHeaderMap.update(headerAuthorization, (value) => '');
      _teammateConnectedSub.sink.add(null);
    }
  }

  void setDefaultHeader(String? token) {
    print('setDefaultHeader $token');
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
