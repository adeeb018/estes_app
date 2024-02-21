import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/pages/settings_page.dart';
import 'package:estes_app/presentation/widgets/bluetooth_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void Function()? onpressed;

  AppBarWidget({
    super.key,
    required this.onpressed, ////////////////onpressed is taken as function in constructor to call backbutton hete
    this.currentView,
    this.bluetoothScreen,
  });
  int? currentView;
  BluetoothScreen? bluetoothScreen;
  // StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // toolbarHeight: 70.0,
      // backgroundColor: Colors.black,
      leading: currentView != 1?IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded), /////on the first page we don't need backbutton so if no currentView is returned from calling function
        onPressed: () {                                     /////it will not have backbutton
          onpressed!();
          if(currentView == 3){
            bluetoothScreen?.disconnect();
          }
        },
        color: Colors.white,
      ):SizedBox(),
      titleSpacing: 0.0,
      title: Image.asset(
        "assets/images/estes_logo_2.png",
        scale: 2.0,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(() => SettingsPage());
          },
          icon: const Icon(Icons.settings),
          iconSize: 30.0,
          color: Colors.white,
        )
      ],
    );
  }
}
