import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:localization/localization.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/firebase_options.dart';
import 'package:team_manager/injection_dependencies.dart';
import 'package:team_manager/routing/navigation.dart';
import 'package:team_manager/theming.dart';

void main() {
  /// Initialize Firebase application and inject FirebaseStorageService.
  /// After firebase context initialization, we can register Firebase services.
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((_) {
    InjectionDependencies.injectDependencies();
    usePathUrlStrategy();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Specify where we should look for the translations.
    LocalJsonLocalization.delegate.directories = ['i18n'];

    return MaterialApp.router(
      title: Constants.appTitle,
      routerDelegate: TeammateRouterDelegate(),
      routeInformationParser: TeammateRouteInformationParser(),
      supportedLocales: const [
        Locale('en', 'EN'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate
      ],
      theme: Theming.buildThemeData(),
      darkTheme: Theming.buildThemeDataDark(),
    );
  }
}
