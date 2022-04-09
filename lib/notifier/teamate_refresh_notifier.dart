import 'package:flutter/cupertino.dart';

class TeamateRefreshNotifier extends ChangeNotifier {
  void refresh() {
    notifyListeners();
  }
}
