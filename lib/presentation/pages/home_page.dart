import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double turns = 0.0;
  List<int> swipeList = [1,2,3,4,5];
  int currentView = 1;

  int previousView = 0;
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
                buildBuilder(currentView),
                Image.asset("assets/images/rocket_1.png"),
              ],
            ),
            FlutterCarousel(
              options: CarouselOptions(
                onPageChanged: (index,reason) {
                  // if(currentView-1 == previousView || currentView < previousView){
                  //   previousView = currentView;
                  //   currentView--;
                  // }else{
                  //   currentView++;
                  //   previousView++;
                  // }
                  currentView = index+1;

                  setState(() {
                    // currentView = 1;
                  });
                },
                height: 50.0,
                indicatorMargin: 10.0,
                showIndicator: true,
                slideIndicator: CircularWaveSlideIndicator(),
                viewportFraction: 0.9,
              ),
              items: swipeList.map((i) {
                return Text('');
              }).toList(),
            ),
            pageInfo(currentView),
          ],
        ));
  }

  Text pageInfo(int val) {
    switch(val){
      case 1: return Text('Lets get started',style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold),);
      case 2: return Text('Pair the device using\npairing code or QR code',style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
      case 3: return Text('Turn up the volume to max',style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold),);
      case 4: return Text('Ensure the bystanders are\nat safe distance',style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,);
      case 5: return Text('Swipe to ready',style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold),);
      default: return Text('Lets get started!',style: TextStyle(color: Colors.white,fontFamily: 'MuseoModerno',fontSize: 22.0,fontWeight: FontWeight.bold),);
    }
  }

  Builder buildBuilder(int i) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: AnimatedRotation(
            turns: i / 4,
            duration: const Duration(seconds: 1),
            child: Image.asset("assets/images/group_1.png"),
          ),
        );
      },
    );
  }

}

// width: MediaQuery.of(context).size.width,
// margin: EdgeInsets.symmetric(horizontal: 5.0),
// decoration: BoxDecoration(
// color: Colors.amber
// ),
// child: Text('text $i', style: TextStyle(fontSize: 16.0),)

// Center(
// child: Stack(
// alignment: Alignment.center,
// children: [
// Container(
// child: Image.asset("assets/images/group_1.png"),
// ),
// Image.asset("assets/images/rocket_1.png"),
// ],
// ),
// ),
