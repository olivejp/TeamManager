import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/firebase_options.dart';
import 'package:team_manager/injection_dependencies.dart';
import 'package:team_manager/notifier/authentication_notifier.dart';
import 'package:team_manager/notifier/competence_creation_notifier.dart';
import 'package:team_manager/notifier/main_navigation_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';
import 'package:team_manager/page/home_page.dart';
import 'package:team_manager/page/sign_in_page.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/theming.dart';

import 'controller/sign_in_controller.dart';
import 'notifier/teamate_refresh_notifier.dart';

void main() {
  InjectionDependencies.injectDependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Specify where we should look for the translations.
    LocalJsonLocalization.delegate.directories = ['i18n'];

    return MaterialApp(
      title: 'Team Manager',
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
      home: FutureBuilder(
        future: initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Le contexte Firebase est disponible à partir d'ici.
            // On peut injecter le service de Firebase Storage.
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => MainNavigationNotifier()),
                ChangeNotifierProvider(create: (_) => TeamateVisualizeNotifier()),
                ChangeNotifierProvider(create: (_) => TeamateRefreshNotifier()),
                ChangeNotifierProvider(create: (_) => CompetenceCreationNotifier()),
                ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
              ],
              child: Consumer<AuthenticationNotifier>(
                builder: (_, authNotifier, child) {
                  if (authNotifier.user == null) {
                    return const SignInPage();
                  } else {
                    return child!;
                  }
                },
                child: const HomePage(),
              ),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "applicationLoading".i18n(),
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black),
                ),
                const Padding(
                  padding: EdgeInsets.all(58.0),
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  /// Initialize Firebase application and inject FirebaseStorageService.
  /// After firebase context initialization, we can register Firebase services.
  Future<void> initializeFirebase() => Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
        (value) {
          GetIt.I.registerSingleton(FirebaseStorageService());
          GetIt.I.registerSingleton(FirebaseAuthenticationService());
          GetIt.I.registerSingleton(SignInController());
        },
      );
}
