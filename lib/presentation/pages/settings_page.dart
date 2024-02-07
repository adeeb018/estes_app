import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        onpressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                themeButton('', 1),
                themeButton('second_screen', 2),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                themeButton('third_screen', 3),
                themeButton('fourth_screen', 4),
                // buildIconButton('', 1),
                // buildIconButton('second_screen', 2),
                // buildIconButton('third_screen', 3),
                // buildIconButton('fourth_screen', 4),
                


              ],
            )
          ],
        ),

      ),
    );
  }

  Ink buildIconButton(String imageName, int themeValue) {
    return Ink(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder()
      ),
      child: IconButton(
                  icon: imageName == ''?Text('') : Image.asset('assets/images/${imageName}.png',width: 100,height: 100,),
                  iconSize: 50,
                  onPressed: () {
                    storeController.currentTheme.value = themeValue;
                    storeController.currentBackground = imageName;
                  },
                ),
    );
  }

  ElevatedButton themeButton(String imageName, int themeValue) {
    return ElevatedButton(
              onPressed: () {
                storeController.currentTheme.value = themeValue;
                storeController.currentBackground = imageName;
              },
              child: Container(
                  height: 100,
                  width: 70,
                child: imageName == ''?Text('') : Image.asset('assets/images/${imageName}.png')
              ),
    );
  }
}
