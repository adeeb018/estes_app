import 'package:estes_app/presentation/pages/page_theme_1.dart';
import 'package:estes_app/presentation/pages/swipe_page.dart';
import 'package:estes_app/presentation/widgets/pairing_code.dart';
import 'package:estes_app/presentation/widgets/swipe_widget.dart';
import 'package:estes_app/presentation/widgets/volume_text_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';

import '../widgets/appBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final CarouselController _carouselController = CarouselController();

  List<int> swipeList = [1, 2, 3, 4, 5, 6];
  int currentView = 1;

  String currentFont = 'MuseoModerno';
  int currentTheme = 1;

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xFF2A7DF9), Color(0xFFDEDFFC)],
  ).createShader(const Rect.fromLTWH(50.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: (currentView == 5 || currentView == 6)?
      const SizedBox(
        height: 50,
      ) :
      SizedBox(
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
              child: corousalText(text: 'Next', fontFamily: currentFont),
            ),
          ],
        ),
      ),

      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: const AppBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (currentTheme == 1) PageThemeOne(currentView: currentView),
              SizedBox(
                height: 200,
                child: ListView(
                  children: [
                    FlutterCarousel(
                      options: CarouselOptions(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (currentView == 3)
                          VolumeToMax(currentTheme: currentTheme),
                        const Padding(padding: EdgeInsets.only(right: 10.0)),
                        pageInfo(currentView),
                      ],
                    ),
                    if (currentView == 2) PairingCode(currentFont: currentFont),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*This function return the text to be printed below the main container page in the homepage, the text content
  will be based on the currentpage view value.
   */
  Widget pageInfo(int currentCorousal) {
    switch (currentCorousal) {
      case 1:
        return corousalText(text: 'Lets get started', fontFamily: currentFont);
      case 2:
        return corousalText(
            text: 'Pair the device using\npairing code or QR code',
            fontFamily: currentFont);
      case 3:
        return corousalText(
            text: 'Turn up the volume to max', fontFamily: currentFont);
      case 4:
        return corousalText(
            text: 'Ensure the bystanders are\nat safe distance',
            fontFamily: currentFont);
      case 5:
        return Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            SwipeWidget(context: context, currentFont: currentFont, linearGradient: linearGradient,swipeText: 'Swipe to Ready', onSwipe: () {
              _carouselController.nextPage();
            },),
          ],
        );
      case 6:
        return Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          SwipeWidget(context: context, currentFont: currentFont, linearGradient: linearGradient,swipeText: 'Swipe to ARM',onSwipe: (){
            _carouselController.nextPage();
          },),
        ],
      );

      // corousalText(text: 'Swipe to ready', fontFamily: currentFont);
      default:
        return corousalText(text: 'Lets get started!', fontFamily: currentFont);
    }
  }

  Text corousalText({required String text, required String fontFamily}) {
    return Text(
      text,
      style: textStyle(fontFamily),
      textAlign: TextAlign.center,
    );
  }

  TextStyle textStyle(String fontFamily) {
    return TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontSize: 20.0,
        fontWeight: FontWeight.w700);
  }

// void nexToswipePage() {
//   Get.to(() => SwipeToNext(getcurrentView: currentView, getcurrentTheme: currentTheme));
// }

/* this function is used for rotating a container in which it will be
  rotated pos/4 for of its current position.
   */
}

