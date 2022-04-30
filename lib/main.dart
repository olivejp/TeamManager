import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/firebase_options.dart';
import 'package:team_manager/notifier/authentication_notifier.dart';
import 'package:team_manager/notifier/competence_creation_notifier.dart';
import 'package:team_manager/notifier/main_navigation_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';
import 'package:team_manager/page/home_page.dart';
import 'package:team_manager/page/sign_in_page.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/firebase_storage_service.dart';
import 'package:team_manager/service/http_interceptor.dart';
import 'package:team_manager/service/interface_default_headers.dart';
import 'package:team_manager/service/service_competence.dart';
import 'package:team_manager/service/service_document.dart';
import 'package:team_manager/service/service_teamate.dart';
import 'package:team_manager/service/service_toast.dart';

import 'controller/sign_in_controller.dart';
import 'notifier/teamate_refresh_notifier.dart';

void main() {
  injectDependencies();

  runApp(
    const MyApp(),
  );
}

void injectDependencies() {
  GetIt.I.registerSingletonAsync(() => Future.value(AuthorizationHeaders()));

  GetIt.I.registerSingletonAsync(() => Future.value(ServiceToast()));

  GetIt.I.registerSingletonWithDependencies(
    () => HttpInterceptor(),
    dependsOn: [ServiceToast],
  );

  GetIt.I.registerSingletonWithDependencies(() {
    final HttpInterceptor interceptor = GetIt.I.get();
    final AuthorizationHeaders authorizationHeaders = GetIt.I.get();
    return ServiceTeamate(
      interceptor: interceptor,
      getHeaders: authorizationHeaders.getDefaultHeaders,
    );
  }, dependsOn: [HttpInterceptor, AuthorizationHeaders]);

  GetIt.I.registerSingletonWithDependencies(() {
    final HttpInterceptor interceptor = GetIt.I.get();
    final AuthorizationHeaders authorizationHeaders = GetIt.I.get();
    return CompetenceService(
      interceptor: interceptor,
      getHeaders: authorizationHeaders.getDefaultHeaders,
    );
  },dependsOn: [HttpInterceptor, AuthorizationHeaders]);

  GetIt.I.registerSingletonWithDependencies(() {
    final HttpInterceptor interceptor = GetIt.I.get();
    final AuthorizationHeaders authorizationHeaders = GetIt.I.get();
    return DocumentService(
      interceptor: interceptor,
      getHeaders: authorizationHeaders.getDefaultHeaders,
    );
  }, dependsOn: [HttpInterceptor, AuthorizationHeaders]);
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
      theme: buildThemeData(),
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
                  final AuthorizationHeaders authorizationHeaders = GetIt.I.get<AuthorizationHeaders>();
                  if (authNotifier.user == null) {
                    authorizationHeaders.setAuthorizationHeader(null);
                    return const SignInPage();
                  } else {
                    authorizationHeaders.setAuthorizationHeader(authNotifier.user!.uid);
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

  ThemeData buildThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xff1d1b26),
      primarySwatch: Colors.grey,
      colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
      textTheme: TextTheme(
        headline1: GoogleFonts.nunito(
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          fontSize: 50,
        ),
        caption: GoogleFonts.nunito(
          color: Colors.grey,
          fontSize: 16,
        ),
        subtitle1: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 18,
        ),
        bodyText1: GoogleFonts.nunito(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        bodyText2: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 15,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}
