import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:team_manager/service/service_toast.dart';

class ToastLayoutWidget extends StatelessWidget {
  ToastLayoutWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;
  final ServiceToast serviceToast = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          child: SizedBox(
            width: 200,
            child: StreamBuilder<List<Toast>>(
                stream: serviceToast.getToast(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.red,
                          child: ListTile(
                            title: Text(data.elementAt(index).message),
                          )
                        );
                      },
                    );
                  }
                  return Center(child: LoadingBouncingGrid.circle());
                }),
          ),
          bottom: 0,
          right: 0,
        ),
      ],
    );
  }
}
