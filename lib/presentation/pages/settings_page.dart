import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';

import '../widgets/background_image_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

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
    borderColor = Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBarWidget( /////////////appbar widget is called and a function parameter is passed so that back functionality can be implemented
        onpressed: () {
          Get.back();
        },
      ),
      body: Stack(
        children: [
          // background image is loaded here with respect to the theme
          BackgroundLoad(context: context),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25.0,top: 80),
                child: Text('Add a Background Image',style: TextStyle(color: Colors.white),),
              ),
              Expanded(
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(25.0),
                  itemCount: imageNames.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    // print(imageNames.length);
                    return _themeButton(imageNames[index], index + 1, index);
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Padding(padding: EdgeInsets.only(top: 0)),
                          _styleButton('MuseoModerno','Font 1'),
                          _styleButton('Khyay','Font 2'),
                          _styleButton('Orbitron','Font 3'),
                          _styleButton('AllertaStencil','Font 4'),
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
    );
  }

  /*
  this function return a button with text styles will be setted by the value in parameter
   */
  TextButton _styleButton(String font, String styleText) {
    return TextButton(onPressed: (){
                          storeController.currentFont.value = font;
                        }, child: CorousalText(text: styleText, color: Colors.white,font:font,));
  }

  /*
    this function return a widget which is a wallpaper button in settings to the gridview builder
   */
  Widget _themeButton(String imageName, int themeValue, int index) {
    return GestureDetector(
      onTap: () {
        storeController.currentTheme.value = themeValue;
        storeController.currentBackground = imageName;//////////////on clicking any themeButton in grid view the getXcontroller is updated with current theme,
        selectedContainer = index;////////////////////////////////// background, and a selection variable is also changed to indicate it is selected.
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          image: imageName != ''
              ? (index + 1 != imageNames.length
                  ? DecorationImage(
                      image: AssetImage('assets/images/$imageName.png'), /////////// for first page and last page there will be no images present
                      fit: BoxFit.fill)
                  : null)
              : null,
          color: index == 0 ? Colors.black : null,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: selectedContainer == index
              ? Border.all(
                  color: Colors.pinkAccent, // border color on selection
                  width: 2.0,
                )
              : (index+1 == imageNames.length?Border.all(/////////////////selected container border should be pink and the final container border should be black
            color: Colors.black, // border color on selection
            width: 1.0,
          ):null),
        ),
        child: imageName == ''
            ? (index + 1 == imageNames.length
                ? const Center(
                    child: Icon(
                    Icons.add_circle_outline_rounded, ///////////////// for the last container we add a '+' icon to its center.
                    color: Colors.white,
                    size: 50,
                  ))
                : null)
            : null,
      ),
    );
  }
}