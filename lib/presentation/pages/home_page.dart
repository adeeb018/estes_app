import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> swipeList = [1,2,3,4,5];
  int currentView = 1;

  String currentfFont = 'MuseoModerno';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                onPageChanged: (index,reason) {
                  currentView = index+1;
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
                currentView == 3?Image.asset('assets/images/sound_image_1.png'):Container(),
                Padding(padding: EdgeInsets.only(right: 10.0)),
                pageInfo(currentView),

              ],
            ),
            currentView == 2?Container(
              height: 50.0,
              width: 300.0,
              margin: EdgeInsets.only(top: 25.0),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.white,width: 2.0),
              ),
              child: Row(
                children: [
                  TextField(
                    decoration: InputDecoration(constraints: BoxConstraints(maxWidth: 200.0),
                      // labelText: 'Pairing code',
                      label: corousalText(text: 'Pairing code', fontFamily: currentfFont),
                      // labelStyle: textStyle(currentfFont),
                    ),
                  ),

                ],
              ),

            ):Container(),

          ],
        ),);
  }

  /*This function return the text to be printed below the main container page in the homepage, the text content
  will be based on the currentpage view value.
   */
  Text pageInfo(int currentCorousal) {
    switch(currentCorousal){
      case 1: return corousalText(text:'Lets get started',fontFamily:currentfFont);
      case 2: return corousalText(text: 'Pair the device using\npairing code or QR code',fontFamily:currentfFont);//,style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center);
      case 3: return corousalText(text: 'Turn up the volume to max',fontFamily:currentfFont);//,style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold));
      case 4: return corousalText(text: 'Ensure the bystanders are\nat safe distance',fontFamily:currentfFont);//,style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold,),textAlign: TextAlign.center);
      case 5: return corousalText(text: 'Swipe to ready',fontFamily:currentfFont);//,style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold));
      default: return corousalText(text: 'Lets get started!',fontFamily:currentfFont);//,style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold));
    }
  }

  Text corousalText({required String text,required String fontFamily}) {
    return Text(text, style: textStyle(fontFamily),textAlign: TextAlign.center,);
  }

  TextStyle textStyle(String fontFamily) {
    return TextStyle(color: Colors.white,
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
