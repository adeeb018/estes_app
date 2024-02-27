import 'package:carousel_slider/carousel_slider.dart';
import 'package:estes_app/presentation/pages/page_theme_1.dart';
import 'package:estes_app/presentation/pages/welcome_page.dart';
import 'package:estes_app/presentation/widgets/background_image_widget.dart';
import 'package:estes_app/presentation/widgets/pairing_code.dart';
import 'package:estes_app/presentation/widgets/swipe_widget.dart';
import 'package:estes_app/presentation/widgets/volume_text_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:get/get.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/corousal_text_style.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';

import '../widgets/loading_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // final int? anyView;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final MaterialStatesController textStatesController = MaterialStatesController();

  final List<int> swipeList = [1, 2, 3, 4, 5, 6];//////////////////////created for carousal view creation

  int currentView = 1;/////////////////////////////////////////////current carousal view

  // int currentTheme = 1;

  StoreController storeController = Get.find<StoreController>();

  late final CarouselController? _carouselController;



  @override
  void initState(){
    super.initState();/////////////////////////////////////////////////////////////////carousal controller is needed in other pages so we instance is created in getX
    _carouselController = storeController.carouselController;/////////////////////////so that we can use anywhere and it is initialized here, so that we don't need to access getX every time
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
              _carouselController?.previousPage();
            },currentView: currentView,)
          : AppBarWidget(onpressed: () {
                Get.offAll(() => const WelcomeWidget());
            }, currentView: 1),
      body: PopScope(
          canPop: false,
          child: _scaffoldBody()),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  /*
  the scaffoldBody is defined here as a stack to contain background image
   */

  Stack _scaffoldBody() {
    return Stack(
      children: [
        BackgroundLoad(context: context),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  child: PageThemeOne(currentView: currentView,mainContext: context,)),
              SizedBox(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      // scrollPhysics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason){
                        currentView = index + 1;
                        //setState is called to update the current page with respect to the current view
                        setState(() {});
                      },
                      // height: 50,
                      viewportFraction: .04,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      aspectRatio: 16/5,
                      // disableCenter: true,
                      enlargeFactor: 0.35,
                      //autoPlay: true,

                    ),
                    items: List.generate(6, (index) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ))
                )
              ),
              SizedBox(
              // color: Colors.blue,
              height: MediaQuery.of(context).size.height/3,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _sliderComponent(),
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

  Widget _sliderComponent() {
    switch (currentView) {
      case 1:
        return _pageInfo();
      case 2:
        return Column(
          children: [_pageInfo(), const PairingCode()],
        );
      case 3:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            direction: Axis.horizontal,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [VolumeToMax(), _pageInfo()],
          ),
        );
      case 4:
        return _pageInfo();
      case 5:
        return _pageInfo();
      case 6:
        return _pageInfo();
      default:
        return const SizedBox();
    }
  }

  /*This function return the text to be printed below the main container page in the homepage, the text content
  will be based on the currentpage view value.
   */

  Widget _pageInfo() {
    switch (currentView) {
      case 1:
        return CorousalText(
            text: 'Lets get started',
            // fontFamily: currentFont,
            color: Colors.white);
      case 2:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 68.0),
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
        return _swipeWidget('Swipe to Ready');
      case 6:
        return _swipeWidget('Swipe to ARM');

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
  Widget _swipeWidget(String text) {
    return Column(
      children: [
        const SizedBox(
          height: 40.0,
        ),
        SwipeWidget(
          context: context,
          // linearGradient: storeController.currentTheme.value == 1?null:null,
          swipeText: text,
          onSwipe: () {
            if(currentView == 5){
              Get.to(() => LoadingWidget(carouselController: _carouselController,)); ////////////////if current view is 5 and on swipe we need to show a loading screen.
            }
            // _carouselController.nextPage();
          },
        ),
      ],
    );
  }

  /*
  bottom navigation bar is present for first 4 view in the slider
  other view doesn't have bottom navigation bar
   */
  SizedBox _bottomNavigationBar() {
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
              // statesController: textStatesController,
              style: const ButtonStyle(alignment: Alignment.bottomRight),
              onPressed: _nextPageConstraintsCheck,
              child: CorousalText(text: 'Next', color: Colors.white),
            ),
          ],
        ),
      );
    }
  }

  /*
  this function check what should be done on each next button press on homepage screen with respect to currentView in carousal controller
   */

  _startBluetoothScan() async{
    storeController.bluetoothScreen.scan();
  }

  Future<void> _nextPageConstraintsCheck() async {

    if(currentView == 1){
      _startBluetoothScan(); ////////////////////////////////////////////here we start scanning for the bluetooth devices.
      _carouselController?.nextPage();
    }
    else if(currentView == 2){//////////////////////////////////////////if we press next on second view page if the pairing code is ok then it connect with the bluetooth device and
      const snackBar = SnackBar(////////////////////////////////////////move to next view in the page if connection problem occurs a snackbar is shown to the user
        content: Text('Try again!!Not Connected'),
      );
      if(_isPairingCodeOk()){
        if(await storeController.bluetoothScreen.connect()) {
          _carouselController?.nextPage();
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
      const snackBar = SnackBar(////////////////////////////////////////////////////here volume of the device is taken using a package and if it is maximum the moved to next view
        content: Text('Please set Device volume to MAX and Try again..'),
      );
      final volume = await FlutterVolumeController.getVolume(); //////////////////getting current volume status
      if(volume == 1.0){
        _carouselController?.nextPage();
      }
      else if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    else{
      _carouselController?.nextPage();
    }
  }


  /*
   this code check whether the entered pairing code is numerical and of 6 digits.
   */

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

}

// class CustomSlider extends CircularWaveSlideIndicator{
//
//   CustomSlider(this.currentView);
//
//   StoreController storeController = Get.find<StoreController>();
//   final int currentView;
//   @override
//   Widget build(int currentPage, double pageDelta, int itemCount) {
//     var activeColor = const Color(0xFFFFFFFF);
//     var backgroundColor = const Color(0x66FFFFFF);
//
//     // if (SchedulerBinding.instance.window.platformBrightness ==
//     //     Brightness.light) {
//     //   activeColor = const Color(0xFF000000);
//     //   backgroundColor = const Color(0xFF878484);
//     // }
//
//     return Container(
//       alignment: alignment,
//       padding: padding,
//       child: SizedBox(
//         width: itemCount * itemSpacing,
//         height: currentView == currentPage?indicatorRadius*5:indicatorRadius * 5,
//         child: CustomPaint(
//           painter: CircularWaveIndicatorPainter(
//             currentIndicatorColor: currentIndicatorColor ?? activeColor,
//             indicatorBackgroundColor:
//             indicatorBackgroundColor ?? backgroundColor,
//             currentPage: currentPage,
//             pageDelta: pageDelta,
//             itemCount: itemCount,
//             radius: storeController.currentView == currentPage?indicatorRadius*3:indicatorRadius*1.5,
//             indicatorBorderColor: indicatorBorderColor,
//             borderWidth: indicatorBorderWidth,
//           ),
//         ),
//       ),
//     );
//   }
// }