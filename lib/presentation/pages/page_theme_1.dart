import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';
class PageThemeOne extends StatefulWidget {
  PageThemeOne({super.key, required this.currentView});

  final int currentView;

  @override
  State<PageThemeOne> createState() => _PageThemeOneState();
}

class _PageThemeOneState extends State<PageThemeOne> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  late Animation _animationRocket;
  late Animation _animationContainer;


  /*
    An animation is given to the container on pressing the keyboard up.
   */
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _animationRocket = Tween<double>(begin: 200,end: 140).animate(_animationController);
    _animationContainer = Tween<double>(begin: 300,end: 230).animate(_animationController);

    storeController.controller = _animationController;
  }


  final StoreController storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
                                      //////////////////////////////////With repect the current Them different elements are returned from here on some instances
    return Obx(() {                   /////////////////////////////////there is only a fixed sizedBox to fill out the portions in the mainpage.
      if (storeController.currentTheme.value == 1) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              height: MediaQuery.of(context).size.height/3,
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _rotatingContainer(widget.currentView),
                  Image.asset("assets/images/rocket_1.png",height: _animationRocket.value,),
                ],
              ),
            );
          }
        );
      }
      else if (storeController.currentTheme.value == 2) {
        return const SizedBox(
          height: 300,
        );
      }
      else if(storeController.currentTheme.value == 3){
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              height: MediaQuery.of(context).size.height/3,
              alignment: Alignment.bottomCenter,
              // color: Colors.red,
              // color: Colors.red,
              // width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/astronaut_1.png',height: _animationContainer.value),
            );
          },
        );
      }
      else {
        return const SizedBox(
          height: 300,
          width: 300,
        );
      }
    });

  }

  /*
  a rotating container is builder for first theme
  this container rotated on changing the currentView in Corousal
   */
  Builder _rotatingContainer(int pos) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: _animationContainer.value,
          color: Colors.black,
          child: AnimatedRotation(
            turns: pos / 4,
            duration: const Duration(seconds: 2),
            child: Image.asset("assets/images/group_1.png"),
          ),
        );
      },
    );
  }
}

// double normalheightOfStackedImage = (200/805.3333333333334)*MediaQuery.of(context).size.height;
