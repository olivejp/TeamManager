import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:team_manager/page/home_page.dart';
import 'package:team_manager/page/not_found_page.dart';
import 'package:team_manager/page/planning/planning_page.dart';
import 'package:team_manager/page/resource_page.dart';
import 'package:team_manager/page/sign_in_page.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/navigation_service.dart';

/// Classe importante qui permet de routing de l'application.
/// Cette classe écoute un service BUS appelé NavigationService qui permet de débrancher
/// vers une nouvelle url. Toujours passer par le NavigationService pour naviguer.
class TeammateRouterDelegate extends RouterDelegate<RoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RoutePath> {
  String? pathName;

  final NavigationService navigationService = GetIt.I.get();
  final FirebaseAuthenticationService firebaseAuthenticationService = GetIt.I.get();

  TeammateRouterDelegate() {
    // Va écouter si l'utilisateur se déconnecte, on renvoie TOUJOURS vers la page SignIn.
    firebaseAuthenticationService.listenAuthChanges().listen((userOrNull) {
      if (userOrNull == null) {
        navigationService.changePath('/signin');
      }
    });

    // Va écouter les nouveaux chemins donnés par le NavigationService.
    navigationService.getPath().listen((newPath) {
      print('New path arrived $newPath');
      pathName = newPath;
      notifyListeners();
    });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  RoutePath get currentConfiguration {
    if (FirebaseAuth.instance.currentUser == null) {
      pathName = '/signin';
    }
    return RoutePath(pathName);
  }

  @override
  Widget build(BuildContext context) {
    final Uri uri = Uri.parse(pathName ?? '/');
    Widget widget;
    if (uri.pathSegments.isNotEmpty) {
      switch (uri.pathSegments.elementAt(0)) {
        case 'signin':
          widget = const SignInPage(path: 'home');
          break;
        case 'home' '':
          widget = const HomePage();
          break;
        case 'resource':
          widget = const ResourcePage();
          break;
        case 'planning':
          widget = PlanningPage();
          break;
        default:
          widget = const NotFoundPage();
      }
    } else {
      widget = const NotFoundPage();
    }

    return Navigator(
        key: navigatorKey,
        pages: [
          MaterialPage(
            key: const ValueKey('page'),
            child: widget,
          ),
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          pathName = null;
          notifyListeners();
          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(RoutePath configuration) async {
    if (configuration.pathName != null) {
      pathName = configuration.pathName;
    }
  }
}

class RoutePath {
  final String? pathName;

  RoutePath(this.pathName);
}

class TeammateRouteInformationParser extends RouteInformationParser<RoutePath> {
  @override
  Future<RoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty || uri.pathSegments.elementAt(0).trim().isEmpty) {
      return RoutePath('/');
    } else {
      return RoutePath(routeInformation.location);
    }
  }

  @override
  RouteInformation restoreRouteInformation(RoutePath configuration) {
    return RouteInformation(location: '${configuration.pathName}');
  }
}
