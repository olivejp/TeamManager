import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/page/route_page.dart';
import 'package:team_manager/page/sign_in_page.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';

class RouteGenerator {
  static String signin = '/signin';
  static String home = '/home';

  static Route<dynamic>? generateRoute(BuildContext context, RouteSettings settings) {
    final FirebaseAuthenticationService firebaseAuthenticationService = GetIt.I.get();

    print('generateRoute bidule');
    // GUARD : Si pas authentifié on renvoie toujours vers la page de SignIn.
    if (!firebaseAuthenticationService.isAuthenticated()) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            SignInPage(path: (settings.name ?? RouteGenerator.home)),
      );
    }

    if (settings.name == signin) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SignInPage(path: (RouteGenerator.home)),
      );
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RoutePage(settings: settings),
      settings: settings,
    );
  }
}
