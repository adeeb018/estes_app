import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';

import '../widgets/backgroundImage_widget.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final StoreController storeController = Get.find<StoreController>();

  late Color borderColor;
  List<String> imageNames = [
    '',
    'second_screen',
    'third_screen',
    'fourth_screen',
    '',
  ];
  int selectedContainer = -1;

  @override
  void initState() {
    // TODO: implement initState
    borderColor = Colors.red;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWidget(
        onpressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: [
          BackgroundLoad(context: context),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text('Add a Background Image',style: TextStyle(color: Colors.white),),
              ),
              Expanded(
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(25.0),
                  itemCount: imageNames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    // print(imageNames.length);
                    return themeButton(imageNames[index], index + 1, index);
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text('Select font',style: TextStyle(color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Padding(padding: EdgeInsets.only(top: 0)),
                          TextButton(onPressed: (){
                            storeController.currentFont = 'MuseoModerno';
                          }, child: CorousalText(text: 'Style 1', color: Colors.white)),
                          TextButton(onPressed: (){
                            storeController.currentFont = 'Khyay';
                          }, child: CorousalText(text: 'Style 2', color: Colors.white)),
                          TextButton(onPressed: (){}, child: CorousalText(text: 'Style 3', color: Colors.white)),
                          TextButton(onPressed: (){}, child: CorousalText(text: 'Style 4', color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),




            ],
          ),

        ],
      ),
      // body: Center(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           themeButton('', 1),
      //           themeButton('second_screen', 2),
      //         ],
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           themeButton('third_screen', 3),
      //           themeButton('fourth_screen', 4),
      //           // buildIconButton('', 1),
      //           // buildIconButton('second_screen', 2),
      //           // buildIconButton('third_screen', 3),
      //           // buildIconButton('fourth_screen', 4),
      //
      //
      //
      //         ],
      //       )
      //     ],
      //   ),
      //
      // ),
    );
  }

  Ink buildIconButton(String imageName, int themeValue) {
    return Ink(
      decoration: const ShapeDecoration(shape: RoundedRectangleBorder()),
      child: IconButton(
        icon: imageName == ''
            ? Text('')
            : Image.asset(
                'assets/images/${imageName}.png',
                width: 100,
                height: 100,
              ),
        iconSize: 50,
        onPressed: () {
          storeController.currentTheme.value = themeValue;
          storeController.currentBackground = imageName;
        },
      ),
    );
  }

  Widget themeButton(String imageName, int themeValue, int index) {
    return GestureDetector(
      onTap: () {
        storeController.currentTheme.value = themeValue;
        storeController.currentBackground = imageName;
        selectedContainer = index;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          image: imageName != ''
              ? (index + 1 != imageNames.length
                  ? DecorationImage(
                      image: AssetImage('assets/images/${imageName}.png'),
                      fit: BoxFit.fill)
                  : null)
              : null,
          color: index == 0 ? Colors.black : null,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: selectedContainer == index
              ? Border.all(
                  color: Colors.pinkAccent, // Default border color
                  width: 2.0,
                )
              : null,
        ),
        child: imageName == ''
            ? (index + 1 == imageNames.length
                ? const Center(
                    child: Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.white,
                    size: 50,
                  ))
                : null)
            : null,
      ),
    );
  }
}

// ElevatedButton(
// style: ButtonStyle(
// shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
// ),
// ),
// onPressed: () {
// storeController.currentTheme.value = themeValue;
// storeController.currentBackground = imageName;
// },
// child:
