import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/service/firebase_authentication_service.dart';
import 'package:team_manager/service/navigation_service.dart';

class LeftBarWidget extends StatelessWidget {
  const LeftBarWidget({
    Key? key,
    this.iconVerticalPadding = 18,
  }) : super(key: key);

  final double iconVerticalPadding;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthenticationService authService = GetIt.I.get();
    final NavigationService navigationService = GetIt.I.get();
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
              Constants.appTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => navigationService.changePath('/${Constants.homePath}'),
                    icon: const Icon(Icons.home),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => navigationService.changePath('/${Constants.resourcePath}'),
                    icon: const Icon(Icons.account_box),
                    tooltip: 'team'.i18n(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: iconVerticalPadding),
                  child: IconButton(
                    onPressed: () => navigationService.changePath('/${Constants.planningPath}'),
                    icon: const Icon(Icons.calendar_today_rounded),
                    tooltip: 'Congés',
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
