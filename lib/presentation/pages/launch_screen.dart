import 'package:estes_app/presentation/pages/home_page.dart';
import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/circle_progress.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vibration/vibration.dart';

import 'after_launch_screen.dart';

class LaunchRocket extends StatefulWidget {
  const LaunchRocket({super.key});

  // final String currentFont;
  @override
  State<LaunchRocket> createState() => _LaunchRocketState();
}

class _LaunchRocketState extends State<LaunchRocket>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));

    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        onpressed: () {
          // Get.to(()=>SwipeToNext(getcurrentView: 5, getcurrentTheme: 1));
          Navigator.popUntil(context,
              ModalRoute.withName('/')); // get to the first page in the stack
        },
      ),
      body: Center(
        child: Flex(
          direction: Axis.vertical,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 10,
              child: Center(
                child: CustomPaint(
                  foregroundPainter: CircleProgress(_animation.value),
                  child: GestureDetector(
                    onLongPress: () async {
                      _animationController.forward();
                      await Vibration.hasCustomVibrationsSupport();
                      Vibration.vibrate(pattern: [100, 700, 200, 700, 200, 700, 200, 700, 200, 1300], intensities: [1, 1, 1, 255]);
                      Future.delayed(Duration(seconds: 5), () {
                        Get.to(() => AfterLaunch());
                      });
                    },
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Image.asset('assets/images/launch_rocket.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              '${((_animation.value / 20).round())}',
              style: TextStyle(color: Colors.black),
            ),
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.topCenter,
                height: 50,
                child: CorousalText(
                    text: 'Hold on rocket\nfor 5 Seconds to launch',
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
