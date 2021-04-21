import 'package:flutter/widgets.dart';

class WinchStateProvider extends ChangeNotifier {
  bool currentState = false;

  getWinchDriverCurrentState(state) {
    currentState = state;
    notifyListeners();
  }
}
