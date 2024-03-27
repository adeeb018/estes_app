import 'package:flutter/material.dart';

class ThemeBorderProvider extends ChangeNotifier {

  int borderSelected = 1;

  int gridLength = 0;

  void changeBorderSelected(int changeVal){
    borderSelected = changeVal;
    notifyListeners();
  }

  void changeGridLength(int changeVal){
    gridLength = changeVal;
    notifyListeners();
  }
}