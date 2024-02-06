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
      appBar: AppBarWidget(onpressed: () {
        Navigator.of(context).pop();
      },),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              storeController.currentTheme.value = 1;
      }, child: Text('1')),
            ElevatedButton(onPressed: (){
      storeController.currentTheme.value = 2;
    }, child: Text('2')),
            ElevatedButton(onPressed: (){
              storeController.currentTheme.value = 3;
            }, child: Text('3')),
            ElevatedButton(onPressed: (){
              storeController.currentTheme.value = 4;
            }, child: Text('4')),
          ],
        ),
      ),
    );
  }
}
