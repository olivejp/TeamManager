import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/competence_creation_notifier.dart';
import 'package:team_manager/notifier/main_navigation_notifier.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';
import 'package:team_manager/notifier/teamate_update_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';
import 'package:team_manager/page/home_page.dart';
import 'package:team_manager/service/service_competence.dart';
import 'package:team_manager/service/service_teamate.dart';

void main() {
  GetIt.I.registerSingleton(ServiceTeamate());
  GetIt.I.registerSingleton(CompetenceService());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainNavigationNotifier()),
        ChangeNotifierProvider(create: (context) => TeamateCreationNotifier()),
        ChangeNotifierProvider(create: (context) => TeamateUpdateNotifier()),
        ChangeNotifierProvider(create: (context) => TeamateVisualizeNotifier()),
        ChangeNotifierProvider(create: (context) => CompetenceCreationNotifier()),
      ],
      child: MaterialApp(
        title: 'Team Manager',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xff1d1b26),
          primarySwatch: Colors.grey,
          textTheme: TextTheme(
            caption: GoogleFonts.nunito(
              color: Colors.grey,
              fontSize: 16,
            ),
            subtitle1: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 18,
            ),
            bodyText1: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
            bodyText2: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
