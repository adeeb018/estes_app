import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 70.0,
          backgroundColor: Colors.black,
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
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: Image.asset("assets/images/group_1.png"),
              ),
              Image.asset("assets/images/rocket_1.png"),
            ],
          ),
        ));
  }
}
