import 'package:flutter/material.dart';
import 'package:team_manager/component/left_bar.dart';
import 'package:team_manager/component/toast_layout_widget.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/page/competence_page.dart';
import 'package:team_manager/page/home_page.dart';
import 'package:team_manager/page/planning/planning_page.dart';
import 'package:team_manager/page/resource_page.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key, this.settings}) : super(key: key);

  final RouteSettings? settings;

  @override
  Widget build(BuildContext context) {
    return ToastLayoutWidget(
      width: 500,
      child: Scaffold(
        body: Builder(
          builder: (context) {
            Widget newPageWidget;
            switch (settings?.name) {
              case '/home':
                newPageWidget = const HomePage();
                break;
              case '/resources':
                newPageWidget = const ResourcePage();
                break;
              case '/competences':
                newPageWidget = const CompetencePage();
                break;
              case '/planning':
                newPageWidget = PlanningPage();
                break;
              default:
                newPageWidget = const HomePage();
            }
            return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LeftBarWidget(),
                  Expanded(
                    child: newPageWidget,
                  ),
                ]);
          },
        ),
      ),
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
