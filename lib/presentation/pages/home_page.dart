import 'dart:developer';

import 'package:estes_app/presentation/pages/page_theme_1.dart';
import 'package:estes_app/presentation/widgets/backgroundImage_widget.dart';
import 'package:estes_app/presentation/widgets/bluetooth_connection.dart';
import 'package:estes_app/presentation/widgets/pairing_code.dart';
import 'package:estes_app/presentation/widgets/swipe_widget.dart';
import 'package:estes_app/presentation/widgets/volume_text_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/corousal_text_style.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // final int? anyView;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();

  final MaterialStatesController textStatesController = MaterialStatesController();


  final List<int> swipeList = [1, 2, 3, 4, 5, 6];

  int currentView = 1;

  // int currentTheme = 1;

  StoreController storeController = Get.find<StoreController>();

  BluetoothScreen bluetoothScreen = BluetoothScreen();

  @override
  void initState(){
    super.initState();
    bluetoothScreen.scan();
  }

  bool _isPairingCodeOk(){
    String pairingCode = storeController.paringTextController.value.text;
    if(pairingCode.length == 6) {
      for(int i=0;i<pairingCode.length;i++){
        if(pairingCode[i].isAlphabetOnly){
          return false;
        }
      }
      return true;
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: currentView != 1
          ? AppBarWidget(onpressed: () {
              _carouselController.previousPage();
            },bluetoothScreen: bluetoothScreen,currentView: currentView,)
          : AppBarWidget(onpressed: () {
              _carouselController.previousPage();
            }, currentView: 1),
      body: scaffoldBody(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  /*
  the scaffoldBody is defined here as a stack to contain background image
   */

  Stack scaffoldBody() {
    return Stack(
      children: [
        BackgroundLoad(context: context),
        SingleChildScrollView(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // direction: Axis.vertical,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: PageThemeOne(currentView: currentView,)),
              Container(
                height: MediaQuery.of(context).size.height/15,
                child: FlutterCarousel(
                  options: CarouselOptions(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _carouselController,
                    onPageChanged: (index, reason) {
                      currentView = index + 1;
                      //setState is called to update the current page with respect to the current view
                      setState(() {});
                    },
                    height: 50.0,
                    indicatorMargin: 10.0,
                    showIndicator: true,
                    slideIndicator: CircularWaveSlideIndicator(),
                    viewportFraction: 0.9,
                  ),
                  items: swipeList.map((i) {
                    return const Text('');
                  }).toList(),
                ),
              ),
              Container(
              // color: Colors.blue,
              height: MediaQuery.of(context).size.height/3,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: sliderComponent(),
              ),
                                  ),
            ],
          ),
        ),
      ],
    );
  }

  /*
  Each Corousal has different data components it is all defined here
  with respect to the currentView of the slider.
   */

  Widget sliderComponent() {
    switch (currentView) {
      case 1:
        return pageInfo();
      case 2:
        return Column(
          children: [pageInfo(), PairingCode()],
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [VolumeToMax(), pageInfo()],
          ),
        );
      case 4:
        return pageInfo();
      case 5:
        return pageInfo();
      case 6:
        return pageInfo();
      default:
        return const SizedBox();
    }
  }

  /*
  bottom navigation bar is present for first 4 view in the slider
  other view doesn't have bottom navigation bar
   */
  SizedBox bottomNavigationBar() {
    if (currentView == 5 || currentView == 6) {
      return const SizedBox(
        height: 50,
      );
    } else {
      return SizedBox(
        height: 50,
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              statesController: textStatesController,
              style: const ButtonStyle(alignment: Alignment.bottomRight),
              onPressed: _nextPageConstraintsCheck,
              child: CorousalText(text: 'Next', color: Colors.white),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _nextPageConstraintsCheck() async {

    if(currentView == 1){
      _carouselController.nextPage();
    }

    else if(currentView == 2){
      const snackBar = SnackBar(
        content: Text('Try again!!Not Connected'),
      );
      if(_isPairingCodeOk()){
        if(await bluetoothScreen.connect()) {
          _carouselController.nextPage();
          await bluetoothScreen.buttonAction([0xA0, 0x01, 0x01, 0xA2]);
        }
        else if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    }
    else if(currentView == 3){
      const snackBar = SnackBar(
        content: Text('Please set Device volume to MAX and Try again..'),
      );
      final volume = await FlutterVolumeController.getVolume();
      if(volume == 1.0){
        _carouselController.nextPage();
      }
      else if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else{
      _carouselController.nextPage();
    }
  }

  Future<void> volumeCheck() async {
    final volume = await FlutterVolumeController.getVolume();
    log("CURRENT VOLUME IS $volume");
  }

  /*This function return the text to be printed below the main container page in the homepage, the text content
  will be based on the currentpage view value.
   */
  Widget pageInfo() {
    switch (currentView) {
      case 1:
        return CorousalText(
            text: 'Lets get started',
            // fontFamily: currentFont,
            color: Colors.white);
      case 2:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Wrap(
            direction: Axis.horizontal,
            children: [CorousalText(
                text: 'Pair the device using pairing code or QR code',
                // fontFamily: currentFont,
                color: Colors.white),
          ],),
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CorousalText(
              text: 'Turn up the volume to max',
              // fontFamily: currentFont,
              color: Colors.white),
        );
      case 4:
        return CorousalText(
            text: 'Ensure the bystanders\nare at safe distance',
            // fontFamily: currentFont,
            color: Colors.white);
      case 5:
        return swipeWidget('Swipe to Ready');
      case 6:
        return swipeWidget('Swipe to ARM');

      default:
        return CorousalText(
          text: 'Some Error Occurred',
          color: Colors.white,
        );
    }
  }

  /*
    this function is used to create a swipe widget and returns to the slider.
   */
  Widget swipeWidget(String text) {
    return Column(
      children: [
        const SizedBox(
          height: 40.0,
        ),
        Obx(() => SwipeWidget(
          context: context,
          // currentFont: currentFont,
          linearGradient: storeController.currentTheme.value == 1?storeController.linearGradient:null,
          swipeText: text,
          onSwipe: () {
            _carouselController.nextPage();
          },
        ),
        ),
      ],
    );
  }
}