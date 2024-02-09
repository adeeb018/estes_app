import 'package:estes_app/presentation/pages/page_theme_1.dart';
import 'package:estes_app/presentation/widgets/backgroundImage_widget.dart';
import 'package:estes_app/presentation/widgets/pairing_code.dart';
import 'package:estes_app/presentation/widgets/swipe_widget.dart';
import 'package:estes_app/presentation/widgets/volume_text_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/corousal_text_style.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();

  final List<int> swipeList = [1, 2, 3, 4, 5, 6];

  int currentView = 1;

  // int currentTheme = 1;

  StoreController storeController = Get.find<StoreController>();

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
            })
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
        Flex(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          direction: Axis.vertical,
          children: [
            Expanded(
                flex: 7,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(flex:12,child:PageThemeOne(currentView: currentView)),
                    Expanded(
                      flex: 1,
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
                  ],
                ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                // color: Colors.blue,
                // height: 220,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    sliderComponent(),
                    // if (currentView == 2) const PairingCode(),
                  ],
                ),
              ),
            ),
          ],
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
              style: const ButtonStyle(alignment: Alignment.bottomRight),
              onPressed: () {
                _carouselController.nextPage();
              },
              child: CorousalText(text: 'Next', color: Colors.white),
            ),
          ],
        ),
      );
    }
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
        return CorousalText(
            text: 'Pair the device using\npairing code or QR code',
            // fontFamily: currentFont,
            color: Colors.white);
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
            text: 'Ensure the bystanders are\nat safe distance',
            // fontFamily: currentFont,
            color: Colors.white);
      case 5:
        return swipeWidget('Swipe to Ready');
      case 6:
        return swipeWidget('Swipe to ARM');

      default:
        return CorousalText(
          text: 'Some Error Occured',
          color: Colors.white,
        );
    }
  }

  /*
    this function is used to create a swipe widget and returns to the slider.
   */
  Column swipeWidget(String text) {
    return Column(
      children: [
        const SizedBox(
          height: 40.0,
        ),
        SwipeWidget(
          context: context,
          // currentFont: currentFont,
          linearGradient: storeController.linearGradient,
          swipeText: text,
          onSwipe: () {
            _carouselController.nextPage();
          },
        ),
      ],
    );
  }
}
