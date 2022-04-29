import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:team_manager/service/service_toast.dart';

class ToastLayoutWidget extends StatelessWidget {
  ToastLayoutWidget(
      {Key? key,
      required this.child,
      this.successColor = Colors.lightGreen,
      this.infoColor = Colors.blue,
      this.warnColor = Colors.orangeAccent,
      this.errorColor = Colors.red,
      this.width = 200,
      this.buildToast})
      : super(key: key);

  final Widget child;
  final double width;
  final Color successColor;
  final Color infoColor;
  final Color warnColor;
  final Color errorColor;
  final Widget Function(Toast toast)? buildToast;
  final ServiceToast serviceToast = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    print('Rebuild ToastLayoutWidget');
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 50,
          right: 50,
          child: SizedBox(
            width: width,
            child: StreamBuilder<List<Toast>>(
                stream: serviceToast.getToast(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final List<Toast> data = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (_, index) {
                        final Toast toast = data.elementAt(index);
                        if (buildToast != null) {
                          return buildToast!(toast);
                        } else {
                          String title = "";
                          String? subtitle;
                          if (toast.title != null) {
                            title = toast.title!;
                            subtitle = toast.message;
                          } else {
                            title = toast.message;
                          }
                          return Card(
                            color: (toast.level == ToastLevel.info)
                                ? infoColor
                                : (toast.level == ToastLevel.warn)
                                ? warnColor
                                : (toast.level == ToastLevel.success)
                                ? successColor
                                : errorColor,
                            child: ListTile(
                              title: Center(child: Text(title)),
                              subtitle: subtitle != null ? Center(child: Text(subtitle)) : null,
                              trailing: toast.icon != null ? Icon(toast.icon) : null,
                            ),
                          );
                        }
                      },
                    );
                  }
                  return Center(child: LoadingBouncingGrid.circle());
                }),
          ),
        ),
      ],
    );
  }
}
