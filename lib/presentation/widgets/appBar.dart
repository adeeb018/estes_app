import 'package:flutter/material.dart';
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // toolbarHeight: 70.0,
      // backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {},
        color: Colors.white,
      ),
      titleSpacing: 0.0,
      title: Image.asset(
        "assets/images/estes_logo_2.png",
        scale: 2.0,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
          iconSize: 30.0,
          color: Colors.white,
        )
      ],
    );
  }
}
