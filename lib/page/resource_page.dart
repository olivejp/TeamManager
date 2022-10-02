import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_manager/component/left_bar.dart';
import 'package:team_manager/component/resource_list_widget.dart';
import 'package:team_manager/component/resource_visualization_widget.dart';
import 'package:team_manager/notifier/teamate_refresh_notifier.dart';
import 'package:team_manager/notifier/teamate_visualization_notifier.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TeamateVisualizeNotifier()),
          ChangeNotifierProvider(create: (_) => TeamateRefreshNotifier()),
        ],
        child: const LeftBarWidget(),
        builder: (context, child) {
          return Scaffold(
            body: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ResourceListWidget(),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: ResourceDetailWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
