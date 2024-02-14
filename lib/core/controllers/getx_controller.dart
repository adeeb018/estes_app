
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class StoreController extends GetxController{

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xFF2A7DF9), Color(0xFFDEDFFC)],
  ).createShader(const Rect.fromLTWH(50.0, 0.0, 200.0, 70.0));

  // final String str = 'hello';
  var currentTheme = 1.obs;
  // var currentView = 1.obs;
  var selectedPairingCode = false.obs;
  var currentBackground = 'second_screen';

  late AnimationController controller;

  var currentFont = 'MuseoModerno'.obs;


}