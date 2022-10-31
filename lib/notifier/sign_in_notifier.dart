import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/navigation_service.dart';
import 'package:team_manager/service/toast_service.dart';

class SignInNotifier extends ChangeNotifier {
  final String path;

  final FirebaseAuthenticationService service = GetIt.I.get();
  final ToastService toastService = GetIt.I.get();
  final NavigationService navigationService = GetIt.I.get();

  String? _email;
  String? _password;
  String? error;
  bool isLoading = false;
  bool hidePassword = true;

  SignInNotifier(this.path) {
    print('SignInNotifier constructor');
    service.teammateConnectedStr().where((user) => user != null).listen((user) {
      print('ChangePath');
      navigationService.changePath(path);
    });
  }

  changeLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  changeHidePassword(bool hidePassword) {
    this.hidePassword = hidePassword;
    notifyListeners();
  }

  setEmail(String? email) {
    _email = email;
  }

  setPassword(String? password) {
    _password = password;
  }

  setError(String? newError) {
    error = newError;
    changeLoading(false);
    notifyListeners();
  }

  pressEnter(GlobalKey<FormState> formKey) {
    changeLoading(true);

    if (formKey.currentState?.validate() == true) {
      service
          .signInWithEmailPassword(_email!, _password!)
          .then((userCredential) => changeLoading(false))
          .catchError((Object? error) => setError(error.toString()));
    } else {
      toastService.addToast(message: 'Le formulaire n\'est pas valide.', level: ToastLevel.success);
    }
  }

  forgotPassword() {
    if (_email == null || _email!.isEmpty) {
      setError("L'email ne peut pas être vide.");
      return;
    }

    service
        .forgotPassword(_email!)
        .then((value) => toastService.addToast(
            message: 'Un message vous a été envoyé pour mettre à jour votre mot de passe.', level: ToastLevel.success))
        .onError((error, stackTrace) =>
            toastService.addToast(message: 'Erreur lors de l\'envoi du message.', level: ToastLevel.error));
  }
}
