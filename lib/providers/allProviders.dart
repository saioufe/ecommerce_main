import 'package:flutter/widgets.dart';

class AllProviders extends ChangeNotifier {
  bool showNavBar = true;

  void NavBarShow(bool show) {
    showNavBar = show;
    notifyListeners();
  }
}
