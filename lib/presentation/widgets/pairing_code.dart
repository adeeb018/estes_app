import 'dart:math';

import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PairingCode extends StatefulWidget {
  PairingCode({super.key});

  @override
  State<PairingCode> createState() => _PairingCodeState();
}

class _PairingCodeState extends State<PairingCode> {

  //focus node is used for getting to now that keyboard is present in the screen or not.
  final FocusNode _focusNode = FocusNode();
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        isKeyboardVisible = _focusNode.hasFocus;
        print(isKeyboardVisible);
        if(isKeyboardVisible == false) {
          storeController.controller.reverse();
          storeController.selectedPairingCode.value = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  final StoreController storeController = Get.find<StoreController>();

  // final String currentFont;
  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.only(top: 20.0),
      child: TextField(
          focusNode: _focusNode,
          onTap: (){
            // _animatedController.forward();
            storeController.selectedPairingCode.value = true;
            storeController.controller.forward();
          },
          cursorColor: Colors.white,
          style: const TextStyle(
              color: Colors.white,
              // fontFamily: currentFont,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              filled: true,
              fillColor: storeController.currentTheme.value == 2?Color.fromRGBO(0, 0, 0, 0.7):Color.fromRGBO(0, 0, 0, 0.4),
              enabledBorder: _pairingCodeBorderStyle(),
              focusedBorder: _pairingCodeBorderStyle(),
              suffixIcon: const Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.qr_code_2_rounded,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
              hintText: 'Pairing code',
              hintStyle: CorousalText(text: 'Pairing code', color: Colors.grey).textStyle()),
        ),
    )
    );
  }

  /*
  for different theme it have different border radius for pairing code
  so for each we pass different parameters here
   */
  OutlineInputBorder _pairingCodeBorderStyle() {

    if(storeController.currentTheme.value == 1){
      return outlineInputBorder(15);
    }else if(storeController.currentTheme.value == 2){
      return outlineInputBorder(10);
    }else if(storeController.currentTheme.value == 3){
      return outlineInputBorder(0);
    }else if(storeController.currentTheme.value == 4){
      return outlineInputBorder(5);
    }
    else{
      return outlineInputBorder(0);
    }
  }

  /*
  border is returned white for 1st theme others are transperant
   */
  OutlineInputBorder outlineInputBorder(double radius) {
    return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    borderSide: storeController.currentTheme.value == 1?BorderSide(color: Colors.white, width: 2.0):BorderSide(color: Colors.transparent),
  );
  }
}
