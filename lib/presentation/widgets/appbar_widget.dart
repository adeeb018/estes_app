import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  AppBarWidget({
    super.key,
    required this.onpressed, ////////////////onpressed is taken as function in constructor to call backbutton here
    this.currentView,
    this.isSettings = false,
  });
  final void Function()? onpressed;

  final int? currentView;

  ///true if the page currently is settings
  final bool isSettings;

  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // toolbarHeight: 70.0,
      // backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded), /////on the first page we don't need backbutton so if no currentView is returned from calling function
        onPressed: () {                                     /////it will not have backbutton
          onpressed!();
          if(currentView == 3){
            storeController.bluetoothScreen.disconnect();
          }
        },
        color: Colors.white,
      ),
      titleSpacing: 0.0,
      title: Image.asset(
        "assets/images/estes_logo_2.png",
        scale: 2.0,
      ),
      actions: [
        isSettings?const SizedBox():IconButton(
          onPressed: () {
            Get.to(() => const SettingsPage(),transition: Transition.cupertino,duration: const Duration(milliseconds: 500));
          },
          icon: const Icon(Icons.settings),
          iconSize: 30.0,
          color: Colors.white,
        )
      ],
    );
  }
}
