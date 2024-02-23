import 'package:estes_app/presentation/pages/home_page.dart';
import 'package:estes_app/presentation/widgets/background_image_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  // StoreController storeController = Get.find<StoreController>();

  @override
  void initState() {
    super.initState();
    _startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          BackgroundLoad(context: context),
          Container(alignment: Alignment.center,child: Image.asset('assets/images/welcome_image.png',alignment: Alignment.center,),),
          Container(
            alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 50),
              child: CorousalText(text: 'WELCOME', color: Colors.white,fontSize: 30,)),
        ],
      ),
    );
  }

  _startTime() async{
    Future ft = Future((){});
    ft = ft.then((_){
      return Future.delayed(const Duration(seconds: 3),(){
        Get.to(() => const HomePage());
      });
    });
  }
}
