import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/backgroundImage_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/page_image_container.dart';

class AfterLaunch extends StatelessWidget {
  AfterLaunch({super.key});

  StoreController storeController = Get.find<StoreController>();
  int currentState = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBarWidget(onpressed: (){
        Navigator.of(context).pop();
      }),
      body: Stack(
        children: [
          BackgroundLoad(context: context),
          Obx(() => storeController.currentTheme.value == 1?SizedBox():Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color.fromRGBO(67, 67, 67, 0.7),
              // rgba(67, 67, 67, 1),
            ),
          ),),
          Center(
            child: Flex(
                direction: Axis.vertical,
                children:[
                  Expanded(flex:5,child: Align(alignment:Alignment.bottomCenter,child: PageImageContainer(currentState: currentState,)),),
                  Expanded(flex:3,child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: pageTextInfo(),
                  ),),
                ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: (currentState == 3 || currentState == 5)?SizedBox():SizedBox(
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
      case 5: return CorousalText(text: 'You have successfully launched\nthe rocket ', color: Colors.white,);
      default: return CorousalText(text: 'Error', color: Colors.white,);
    }
  }
}
