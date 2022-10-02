import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_manager/component/left_bar.dart';
import 'package:team_manager/constants.dart';
import 'package:team_manager/page/route_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'fr_FR');

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LeftBarWidget(),
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
      ),
    );
  }
}
