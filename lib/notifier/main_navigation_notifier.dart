import 'package:flutter/widgets.dart';

class MainNavigationNotifier extends ChangeNotifier {
  String mainPageName = 'home';

  setMainPageName(String newMainPageName) {
    mainPageName = newMainPageName;
    notifyListeners();
  }
}
