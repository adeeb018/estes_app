import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CorousalText extends StatelessWidget {
  CorousalText({super.key,required this.text,required this.color});

  final StoreController storeController = Get.find<StoreController>();
  final String text;
  // final String fontFamily;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (storeController.currentTheme.value != 0) {///problem persists..obx not working
        return Text(
          text,
          style: textStyle(),
          textAlign: TextAlign.center,
        );
      }
      else {
        return SizedBox();
      }
    });
  }

  TextStyle textStyle() {
    return TextStyle(
        color: color,
        fontFamily: storeController.currentFont,
        fontSize: 20.0,
        fontWeight: FontWeight.w700);
  }
}
