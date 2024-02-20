import 'dart:math';

import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:estes_app/presentation/widgets/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PairingCode extends StatefulWidget {
  PairingCode({super.key});

  @override
  State<PairingCode> createState() => _PairingCodeState();
}

class _PairingCodeState extends State<PairingCode> {
  final StoreController storeController = Get.find<StoreController>();
  final TextEditingController textController = TextEditingController();


  // final String currentFont;
  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.only(top: 20.0),
      child: TextField(
          controller: textController,
          keyboardType: TextInputType.number,
          onTap: (){
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
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.qr_code_2_rounded,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  onPressed: () {
                    // print('hello');
                    // Get.to(() => QrScreen());
                  },
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
      return _outlineInputBorder(15);
    }else if(storeController.currentTheme.value == 2){
      return _outlineInputBorder(10);
    }else if(storeController.currentTheme.value == 3){
      return _outlineInputBorder(0);
    }else if(storeController.currentTheme.value == 4){
      return _outlineInputBorder(5);
    }
    else{
      return _outlineInputBorder(0);
    }
  }

  /*
  border is returned white for 1st theme others are transperant
   */
  OutlineInputBorder _outlineInputBorder(double radius) {
    return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    borderSide: storeController.currentTheme.value == 1?BorderSide(color: Colors.white, width: 2.0):BorderSide(color: Colors.transparent),
  );
  }
}
