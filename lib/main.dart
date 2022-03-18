import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/notifier/competence_creation_notifier.dart';
import 'package:team_manager/notifier/teamate_creation_notifier.dart';
import 'package:team_manager/page/competence_page.dart';
import 'package:team_manager/page/error_router_page.dart';
import 'package:team_manager/page/home_page.dart';
import 'package:team_manager/page/planning_page.dart';
import 'package:team_manager/page/team_creation_page.dart';
import 'package:team_manager/page/team_update_page.dart';
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
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            pageBuilder: (_, state) => MaterialPage(
                  key: state.pageKey,
                  child: const HomePage(),
                ),
            routes: [
              GoRoute(
                path: 'planning',
                pageBuilder: (_, state) => MaterialPage(
                  key: state.pageKey,
                  child: const PlanningPage(),
                ),
              ),
              GoRoute(
                path: 'competence',
                pageBuilder: (_, state) => MaterialPage(
                  key: state.pageKey,
                  child: const CompetencePage(),
                ),
              ),
              GoRoute(
                  path: 'resources',
                  pageBuilder: (_, state) => MaterialPage(
                        key: state.pageKey,
                        child: const TeamCreationPage(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'update/:id',
                      pageBuilder: (_, state) => MaterialPage(
                        key: state.pageKey,
                        child: TeamUpdatePage(id: state.params['id'] as String),
                      ),
                    ),
                  ])
            ])
      ],
      initialLocation: '/',
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ErrorRouterPage(),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TeamateCreationNotifier()),
        ChangeNotifierProvider(create: (context) => CompetenceCreationNotifier()),
      ],
      child: MaterialApp.router(
        title: 'Team Manager',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
      ),
    );
  }
}
