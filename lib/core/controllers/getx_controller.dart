
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

import '../../presentation/widgets/bluetooth_connection.dart';

class StoreController extends GetxController{

  // final Shader linearGradient = const LinearGradient(
  //   colors: <Color>[Color(0xFF2A7DF9), Color(0xFFDEDFFC)],
  // ).createShader(const Rect.fromLTWH(50.0, 0.0, 200.0, 70.0));

  var currentTheme = 1.obs;

  // var selectedPairingCode = false.obs;

  var currentBackground = 'first_screen.png';

  var currentFont = 'MuseoModerno'.obs;

  var paringTextController = TextEditingController().obs;

  final CarouselController? carouselController = CarouselController();

  late BluetoothScreen bluetoothScreen;


}