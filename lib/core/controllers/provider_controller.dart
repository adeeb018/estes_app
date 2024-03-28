import 'package:flutter/material.dart';

class ProviderController extends ChangeNotifier {

  int borderSelected = 1;

  int gridLength = 0;
  
  bool isLoading = false;

  void changeBorderSelected(int changeVal){
    borderSelected = changeVal;
    notifyListeners();
  }

  void changeGridLength(int changeVal){
    gridLength = changeVal;
    notifyListeners();
  }
  
  void changeIsLoading(bool changeVal){
    isLoading = changeVal;
    notifyListeners();
  }
}