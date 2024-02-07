import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PairingCode extends StatelessWidget {
  PairingCode({super.key});

  final StoreController storeController = Get.find<StoreController>();

  // final String currentFont;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => TextField(
          cursorColor: Colors.white,
          style: const TextStyle(
              color: Colors.white,
              // fontFamily: currentFont,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
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
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        )
      ),
      );
  }

  OutlineInputBorder _pairingCodeBorderStyle() {

    if(storeController.currentTheme == 1){
      return outlineInputBorder(15);
    }else if(storeController.currentTheme == 2){
      return outlineInputBorder(10);
    }else if(storeController.currentTheme == 3){
      return outlineInputBorder(0);
    }else if(storeController.currentTheme == 4){
      return outlineInputBorder(5);
    }
    else{
      return outlineInputBorder(0);
    }
  }

  OutlineInputBorder outlineInputBorder(double radius) {
    return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    borderSide: const BorderSide(color: Colors.white, width: 2.0),
  );
  }
}
