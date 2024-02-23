import 'dart:async';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/widgets/backgroundImage_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/circle_progress.dart';
import '../widgets/corousal_text_style.dart';
import '../widgets/load_rocket_animation.dart';
import 'after_launch_screen.dart';

class LaunchRocket extends StatefulWidget {
  const LaunchRocket({Key? key}) : super(key: key);

  @override
  State<LaunchRocket> createState() => _LaunchRocketState();
}

class _LaunchRocketState extends State<LaunchRocket>
    with TickerProviderStateMixin {

  StoreController storeController = Get.find<StoreController>();

  bool isLaunchTimeVisible = false;
  bool isVibrating = false;
  int buttonHeldPosition = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  late AnimationController _rocketAnimationController;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
  }

  /*
  An animation controller is needed for showing the progress bar on button hold
   */

  void _initializeAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );

    _rocketAnimationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 5000),);


    _animation = Tween<double>(begin: 0, end: 100).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.addStatusListener(_animationStatusListener);
  }

  /*
the status listener listen for values forward,completed,reverse and dismissed
          On forward   :- In timer is set to call the vibrating function for 5 times and it will be called only if isVibrating is true. else timer is canceled
          On Reverse   :- Here also on each second the buttonHeldPosition is decremented so that if we hold while on reverse we can start from where we left off and if forward is working the timer on reverse will be stopeed
          On complete  :- Here we route to success page
          On Dismissed :- everything is set to initial point values.
 */

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      _handleForwardAnimation();
    } else if (status == AnimationStatus.completed) {
      _handleAnimationCompleted();
    } else if (status == AnimationStatus.reverse) {
      _handleReverseAnimation();
    } else if (status == AnimationStatus.dismissed) {
      _handleAnimationDismissed();
    }
  }

  void _handleForwardAnimation() {
    isVibrating = false;
    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (buttonHeldPosition >= 5 || isVibrating) {
        timer.cancel();
      }
      if (!isVibrating) {
        _vibrate(buttonHeldPosition++);
      }
    });
  }

  Future<void> _handleAnimationCompleted() async {
    await storeController.bluetoothScreen.buttonAction([0xA0, 0x02, 0x01, 0xA3]);
    Get.off(() => const AfterLaunch());
  }

  void _handleReverseAnimation() {
    isVibrating = true;
    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (isVibrating) {
        buttonHeldPosition--;
      } else if (!isVibrating) {
        timer.cancel();
      }
    });
  }

  void _handleAnimationDismissed() {
    buttonHeldPosition = 0;
    isVibrating = false;
  }

  void _vibrate(int times) async {
    await Vibration.hasCustomVibrationsSupport();
    if (times == 4) {
      Vibration.vibrate(duration: 1300);
    } else {
      Vibration.vibrate(duration: 300);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.removeListener(() {});
    _animationController.removeStatusListener(_animationStatusListener);
    _rocketAnimationController.dispose();
    super.dispose();
  }

  int _launchTime(){
    int roundVal = (_animation.value / 20).round();
    switch(roundVal){
      case 0: return 5;
      case 1: return 4;
      case 2: return 3;
      case 3: return 2;
      case 4: return 1;
      case 5: return 0;
      default: return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBarWidget(
        onpressed: () {
          storeController.carouselController.previousPage();
          Future ft = Future(() {});
          ft = ft.then((_){
            return Future.delayed(const Duration(milliseconds: 200),(){/////////////////here on pressing back button we navigate to 5 th currentView of homePage.
              Get.back();///////////////////////////////////////////////////////////////the 200 millisecond delay is used to remove the transition of 6 th view to 5 th from user.
            });
          });
        },
      ),
      body: Stack(
        children: [
          BackgroundLoad(context: context),
          Center(
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(
                  flex: 10,
                  child: Center(
                    child: CustomPaint(
                      foregroundPainter: CircleProgress(currentProgress: _animation.value,context:context),
                      child: GestureDetector(
                        onLongPressStart: (e) {
                          isLaunchTimeVisible = true;
                          _animationController.forward();
                          _rocketAnimationController.repeat();
                        },
                        onLongPressUp: () {
                          isLaunchTimeVisible = false;
                          _animationController.reverse();
                          _rocketAnimationController.reverse();
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height/3,
                          child: Center(child: LoadRocketLaunchAnimation(rocketAnimationController: _rocketAnimationController)),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                    isLaunchTimeVisible?Text(
                    '${_launchTime()}',
                          style: const TextStyle(color: Colors.white),
                      )
                      :const SizedBox(),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 50,
                        child: CorousalText(
                            text: 'Hold on rocket\nfor 5 Seconds to launch',
                            color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


