import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/toast_layout_widget.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/notifier/main_navigation_notifier.dart';
import 'package:team_manager/page/competence_page.dart';
import 'package:team_manager/page/planning_page.dart';
import 'package:team_manager/page/team_creation_page.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final double iconVerticalPadding = 18;

  @override
  Widget build(BuildContext context) {
    return ToastLayoutWidget(
      width: 500,
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LeftBarWidget(iconVerticalPadding: iconVerticalPadding),
            Expanded(
              child: Builder(builder: (context) {
                final String mainPageName =
                    context.select<MainNavigationNotifier, String>((notifier) => notifier.mainPageName);
                switch (mainPageName) {
                  case 'home':
                    return const LayoutHomeWidget();
                  case 'resources':
                    return const TeamVisualizationPage();
                  case 'competences':
                    return const CompetencePage();
                  case 'planning':
                    return const PlanningPage();
                  default:
                    return const LayoutHomeWidget();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class LayoutHomeWidget extends StatelessWidget {
  const LayoutHomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              const SearchBarWidget(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 18,
                  right: 18,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: Constants.borderRadius,
                    color: Constants.primaryColor,
                  ),
                  height: 200,
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Constants.secondaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  color: Constants.iconColor,
                                  size: 16,
                                ),
                                Text(
                                  formatter.format(now),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                          const Text('Good Day, Dr. Nicholls'),
                          const Text('Have a Nice Monday!')
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 18, left: 12),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cancel_rounded),
          ),
          hintText: 'Rechercher un collaborateur',
          hintStyle: const TextStyle(
            color: Constants.greyColor,
          ),
          suffixIconColor: Colors.white,
          fillColor: Constants.backgroundColor,
        ),
      ),
    );
  }
}

class LeftBarWidget extends StatelessWidget {
  LeftBarWidget({
    Key? key,
    required this.iconVerticalPadding,
  }) : super(key: key);

  final double iconVerticalPadding;
  final FirebaseAuthenticationService authService = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: Constants.borderRadius,
          color: Constants.primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Team Manager',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => context.read<MainNavigationNotifier>().setMainPageName('home'),
                    icon: const Icon(Icons.home),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => context.read<MainNavigationNotifier>().setMainPageName('resources'),
                    icon: const Icon(Icons.account_box),
                    tooltip: 'team'.i18n(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => context.read<MainNavigationNotifier>().setMainPageName('competences'),
                    icon: const Icon(Icons.send_rounded),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.apps_rounded),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => context.read<MainNavigationNotifier>().setMainPageName('planning'),
                    icon: const Icon(Icons.calendar_today_rounded),
                  ),
                ),
              ],
            ),
            IconButton(
              tooltip: 'sign_out'.i18n(),
              onPressed: authService.signOut,
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
    );
  }
}
