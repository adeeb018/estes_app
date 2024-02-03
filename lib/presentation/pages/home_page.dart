import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> swipeList = [1, 2, 3, 4, 5];
  int currentView = 1;

  String currentfFont = 'MuseoModerno';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      // currentView == 5?Container():
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            style: ButtonStyle(alignment: Alignment.bottomRight),
            onPressed: () {  },
            child: corousalText(text: 'Next', fontFamily: currentfFont),
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        // toolbarHeight: 70.0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {},
          color: Colors.white,
        ),
        titleSpacing: 0.0,
        title: Image.asset(
          "assets/images/estes_logo_2.png",
          scale: 2.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            iconSize: 30.0,
            color: Colors.white,
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    rotatingContainer(currentView),
                    Image.asset("assets/images/rocket_1.png"),
                  ],
                ),
                FlutterCarousel(
                  options: CarouselOptions(
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
                    currentView == 3
                        ? Image.asset('assets/images/sound_image_1.png')
                        : Container(),
                    const Padding(padding: EdgeInsets.only(right: 10.0)),
                    pageInfo(currentView),
                  ],
                ),
                currentView == 2
                    ? Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white,fontFamily: currentfFont,fontSize: 20.0,fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: pairingCodeBorderStyle(),
                            focusedBorder: pairingCodeBorderStyle(),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.qr_code_2_rounded,color: Colors.white,size: 50.0,),
                            ),

                            // constraints: const BoxConstraints(maxWidth: 200.0),
                            // labelText: 'Pairing code',
                            hintText: 'Pairing code',
                            hintStyle: TextStyle(color: Colors.grey,fontFamily: currentfFont,fontSize: 20.0,fontWeight: FontWeight.bold)
                            // labelStyle: textStyle(currentfFont),
                          ),
                        ),
                      )
                    : Container(),
                // const Icon(Icons.qr_code_2_rounded,color: Colors.white,size: 45.0,),
                // Padding(padding: EdgeInsets.only(right: 0.0))
              ],
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder pairingCodeBorderStyle() {
    return const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                          );
  }

  /*This function return the text to be printed below the main container page in the homepage, the text content
  will be based on the currentpage view value.
   */
  Text pageInfo(int currentCorousal) {
    switch (currentCorousal) {
      case 1:
        return corousalText(text: 'Lets get started', fontFamily: currentfFont);
      case 2:
        return corousalText(
            text: 'Pair the device using\npairing code or QR code',
            fontFamily: currentfFont);
      case 3:
        return corousalText(
            text: 'Turn up the volume to max', fontFamily: currentfFont);
      case 4:
        return corousalText(
            text: 'Ensure the bystanders are\nat safe distance',
            fontFamily: currentfFont);
      case 5:
        return corousalText(text: 'Swipe to ready', fontFamily: currentfFont);
      default:
        return corousalText(
            text: 'Lets get started!', fontFamily: currentfFont);
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

  /* this function is used for rotating a container in which it will be
  rotated pos/4 for of its current position.
   */
  Builder rotatingContainer(int pos) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: AnimatedRotation(
            turns: pos / 4,
            duration: const Duration(seconds: 2),
            child: Image.asset("assets/images/group_1.png"),
          ),
        );
      },
    );
  }
}
