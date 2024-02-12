import 'package:estes_app/presentation/pages/successfull_launch_screen.dart';
import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LaunchRocket extends StatefulWidget {
  const LaunchRocket({super.key});

  // final String currentFont;
  @override
  State<LaunchRocket> createState() => _LaunchRocketState();
}

class _LaunchRocketState extends State<LaunchRocket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        onpressed: (){
          // Get.to(()=>SwipeToNext(getcurrentView: 5, getcurrentTheme: 1));
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onLongPress: (){
                  print('hello');
                  Future.delayed(Duration(seconds: 1),(){
                    print('hello');
                  });
                  Future.delayed(Duration(seconds: 2),(){
                    print('hello');

                  });
                  Future.delayed(Duration(seconds: 3),(){
                    print('hello');

                  });
                  Future.delayed(Duration(seconds: 4),(){
                    print('hello');

                  });
                  Future.delayed(Duration(seconds: 5),(){
                    Get.to(() => SuccessScreen());
                  });
                },
                child: Image.asset('assets/images/launch_rocket.png'),),
            SizedBox(
              height: 50,
              child: CorousalText(text: 'Hold on rocket\nfor 5 Seconds to launch',color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
