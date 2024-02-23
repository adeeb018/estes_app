import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/background_image_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/page_image_container.dart';

class AfterLaunch extends StatefulWidget {
  const AfterLaunch({super.key});

  @override
  State<AfterLaunch> createState() => _AfterLaunchState();
}

class _AfterLaunchState extends State<AfterLaunch> {

  final StoreController storeController = Get.find<StoreController>();

  int currentState = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBarWidget(onpressed: () async {
        storeController.carouselController.previousPage();

        await storeController.bluetoothScreen.buttonAction([0xA0, 0x01, 0x00, 0xA1]);/////here both lights of device has been turned off
        await storeController.bluetoothScreen.buttonAction([0xA0, 0x02, 0x00, 0xA2]);

        Future ft = Future(() {});
        ft = ft.then((_){
          return Future.delayed(const Duration(milliseconds: 200),(){////////////////////////here on pressing back button we navigate to 5 th currentView of homePage.
            Get.back();//////////////////////////////////////////////the 200 millisecond delay is used to remove the transition of 6 th view to 5 th from user.
          });
        });
      }),
      body: Stack(
        children: [
          BackgroundLoad(context: context),
          Obx(() => storeController.currentTheme.value == 1?const SizedBox():Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(45, 45, 45, 0.82),
              // rgba(67, 67, 67, 1),
            ),
          ),),
          Center(
            child: Flex(
                direction: Axis.vertical,
                children:[
                  Expanded(flex:10,child: Align(alignment:Alignment.bottomCenter,child: PageImageContainer(currentState: currentState,)),),
                  Expanded(flex:5,child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: pageTextInfo(),
                  ),),
                ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: (currentState == 3 || currentState == 5)?const SizedBox():SizedBox(
        height: 60,
        child: TextButton(
          style: const ButtonStyle(alignment: Alignment.center),
          onPressed: () {
          },
          child: bottomNavigationcorousalText(),
        ),
      ),
    );
  }

  CorousalText bottomNavigationcorousalText() {
    switch(currentState){
      case 1: return CorousalText(text: 'Allow permissions', color: Colors.white);
      case 2: return CorousalText(text: 'Troubleshoot Guide', color: Colors.white);
      case 4: return CorousalText(text: 'Help & Guide', color: Colors.white);
      default: return CorousalText(text: 'Error', color: Colors.white);
    }
  }

  Widget pageTextInfo() {
    switch(currentState){
      case 1: return CorousalText(text: 'Camera and location permissions\nneeds to be allowed', color: Colors.white,);
      case 2: return CorousalText(text: 'We are facing some issue\nplease wait while we figure it out', color: Colors.white,);
      case 3: return CorousalText(text: 'Somethings not right\nplease stay away from rocket\nfor 60 seconds', color: Colors.white,);
      case 4: return CorousalText(text: 'There is something wrong', color: Colors.white,);
      case 5: return Padding(
        padding: const EdgeInsets.only(left:4.0,right: 4.0),
        child: CorousalText(text: 'You have successfully launched\nthe rocket ', color: Colors.white,),
      );
      default: return CorousalText(text: 'Error', color: Colors.white,);
    }
  }
}
