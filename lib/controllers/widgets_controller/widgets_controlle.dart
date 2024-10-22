import 'package:flutter/material.dart';

class WidgetsController extends ChangeNotifier {
  //bottom navigation bar items
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
