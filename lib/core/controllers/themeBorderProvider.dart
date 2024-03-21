import 'package:flutter/material.dart';

class ThemeBorderProvider extends ChangeNotifier {

  int borderSelected = 1;

  void changeBorderSelected(int changeVal){
    borderSelected = changeVal;
    notifyListeners();
  }
}