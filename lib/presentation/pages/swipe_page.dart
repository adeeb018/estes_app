import 'package:estes_app/presentation/pages/page_theme_1.dart';
import 'package:estes_app/presentation/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../widgets/volume_text_image.dart';

class SwipeToNext extends StatefulWidget {
  const SwipeToNext({super.key,required this.getcurrentView,required this.getcurrentTheme});

  final int getcurrentView;
  final int getcurrentTheme;
  @override
  State<SwipeToNext> createState() => _SwipeToNextState();
}

class _SwipeToNextState extends State<SwipeToNext> {

  late int currentView;
  late int currentTheme;
  @override
  void initState() {
    currentView = widget.getcurrentView;
    currentTheme = widget.getcurrentTheme;
    super.initState();
  }

  List<int> swipeList = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar:
      appBar: const AppBarWidget(),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(currentTheme == 1)
            PageThemeOne(currentView: currentView),
          SizedBox(
            height: 200,
            child: ListView(
              children: [
                FlutterCarousel(
                  options: CarouselOptions(
                    initialPage: 5,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
