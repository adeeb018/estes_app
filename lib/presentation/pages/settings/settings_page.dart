import 'dart:developer';
import 'dart:io';

import 'package:estes_app/core/controllers/provider_controller.dart';
import 'package:estes_app/presentation/pages/settings/widgets.dart';
import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/image_path_and_name.dart';
import 'package:estes_app/presentation/widgets/upload_background_image.dart';
import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/corousal_text_style.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}



class _SettingsPageState extends State<SettingsPage> {
  final StoreController storeController = Get.find<StoreController>();

  late Color borderColor;

  List<ImageContainers> imageContainers = [
    ImageContainers(
        type: true,
        imageName: 'first_screen.png',
        imagePath: 'assets/images/first_screen.png',
        selectedContainer: true),
    ImageContainers(
        type: true,
        imageName: 'second_screen.png',
        imagePath: 'assets/images/second_screen.png'),
    ImageContainers(
        type: true,
        imageName: 'third_screen.png',
        imagePath: 'assets/images/third_screen.png'),
    ImageContainers(
        type: true,
        imageName: 'fourth_screen.png',
        imagePath: 'assets/images/fourth_screen.png'),
    ImageContainers(type: false)
  ];

  // = imageNames.indexOf(storeController.currentBackground);
  int selectedFont = -1;

  @override
  void initState() {
    borderColor = Colors.red;
    super.initState();
  }

  Future<void> _loadImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the value with the given key exists in shared preferences
    bool containsValue = prefs.containsKey('imageContainersList');

    if (containsValue) {
      //if anything present on shared preference then copy it in to imageContainer object by clearing all of the data in it.
      imageContainers.clear();
      imageContainers = [...await SaveOrLoadImageFromSP.loadImageContainersList('imageContainersList')];
      log('SHARED PREFERENCE IS ALREADY INITIALIZED');
    } else {
      //convert imageNames list to json and add to sharedPreferences.
      SaveOrLoadImageFromSP.saveImageContainersList(imageContainers,'imageContainersList');
      log('SHARED PREFERENCE initialized');
    }
  }

  /*
  this function is used to select the current background image on Loading
   */
  _selectContainerOnLoading(){
    for(ImageContainers imageContainer in imageContainers){
      if(imageContainer.imageName == storeController.currentBackground){
        imageContainer.selectedContainer = true;
      }
    }
  }

  Future<void> _builderInitialize() async{
    await _loadImageData().then((_) => _selectContainerOnLoading());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBarWidget(
        onpressed: () {
          Get.back();
        },
        isSettings: true,
      ),
      body: PopScope(
        canPop: false,
        child: FutureBuilder(
            future: _builderInitialize(),
            builder: (context, snapshot) {
              if(snapshot.connectionState ==ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.hasError){
                return Text('Error - ${snapshot.error}');
              }
              else{
                return Stack(
                  children: [
                    BackgroundLoad(
                      context: context,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _themeHeading(),
                        _themeContainers(),
                        _themeFonts(),
                      ],
                    )
                  ],
                );
              }
            }
        ),
      ),
    );
  }


  //////////themHeading section

  Padding _themeHeading() {
    return const Padding(
      padding: EdgeInsets.only(left: 25.0, top: 80),
      child: Text(
        'Add a Background Image',
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  /////////_themeContainer Section

  Widget _themeContainers() {
    return Consumer<ProviderController>(
        builder: (context, dataProvider, _) {
          return Expanded(
            child: GridView.builder(
              // physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(25.0),
              itemCount: imageContainers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                // print(imageNames.length);
                return _themeButtons(index,dataProvider);
              },
            ),
          );
        });
  }


  Widget _themeButtons(int index,ProviderController dataProvider) {
    int themeVal = index + 1;
          return GestureDetector(
            onTap: () {
              // if we press on add image Container background image should not be changed
              if (imageContainers[index].type) {

                storeController.currentTheme.value = themeVal;

                for (ImageContainers imageContainer in imageContainers) {
                  imageContainer.selectedContainer = false;
                }

                // image added from storage , if the image is asset we can load that image from its name itself.
                if(imageContainers[index].storageType){
                  storeController.currentBackgroundPath.value = imageContainers[index].imagePath!;
                }
                storeController.currentBackground = imageContainers[index].imageName!;
                imageContainers[index].selectedContainer = true;
                Provider.of<ProviderController>(context, listen: false).changeBorderSelected(index + 1);
              }
              else{
                _loadImageFromStorage();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                image: _imageOrAddFile(index),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: _borderSelectedContainer(index, dataProvider.borderSelected),
              ),
              child: _addNewTheme(index),
            ),
          );
  }


  DecorationImage? _imageOrAddFile(int index) {
    if (imageContainers[index].type) {
      return DecorationImage(image: _loadImage(index), fit: BoxFit.cover);
    }
    else{
    }
    return null;
  }

  Border? _borderSelectedContainer(int index, int selected) {
    if(imageContainers[index].type == false){
      return Border.all(
        color: Colors.grey, // border color on selection
        width: 1.0,
      );
    }
    if (imageContainers[index].selectedContainer && index + 1 == storeController.currentTheme.value && selected == index + 1) {
      return Border.all(
        color: Colors.pinkAccent, // border color on selection
        width: 2.0,
      );
    }
    return null;
  }

  Widget? _addNewTheme(int index) {
    if (imageContainers[index].type == false) {
      return Center(
        child: IconButton(
          onPressed: _loadImageFromStorage,
          icon: const Icon(Icons.add_circle_outline_rounded,color: Colors.white,size: 50),
          ///////////////// for the last container we add a '+' icon to its center.

        ),
      );
    }
    return null;
  }

  _loadImageFromStorage() async{
    ImagePathAndName? imageDetails = await UploadImage.getImage();
    if(imageDetails == null){
      log('NO IMAGE LOADED FROM EXTERNAL STORAGE');
    }else{
      ImageContainers newImage = ImageContainers(type: true,imagePath: imageDetails.imagePath,storageType: true,imageName: imageDetails.imageName);
      imageContainers.insert(imageContainers.length - 1, newImage);
      // imageContainers.insert(newImage);
      SaveOrLoadImageFromSP.saveImageContainersList(imageContainers,'imageContainersList');
      if(context.mounted){
        Provider.of<ProviderController>(context, listen: false).changeGridLength(imageContainers.length + 1);
      }
    }
  }

  _loadImage(int index) {
    if (imageContainers[index].storageType) {

      return FileImage(File(imageContainers[index].imagePath!));
    }
    else{
      return AssetImage(
          imageContainers[index].imagePath ?? 'assets/images/first_screen.png');
    }
  }


  ///////////////_themFonts section



  Column _themeFonts() {
    return Column(
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
                _styleButton('MuseoModerno', 'Font 1'),
                _styleButton('Khyay', 'Font 2'),
                _styleButton('Orbitron', 'Font 3'),
                _styleButton('AllertaStencil', 'Font 4'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /*
  this function return a button with text styles will be setted by the value in parameter
   */
  Widget _styleButton(String font, String styleText) {
    return Obx(() => Container(
      decoration: BoxDecoration(
          border: storeController.currentFont.value == font
              ? Border.all(
            color: Colors.pinkAccent, // border color on selection
            width: 2.0,
          )
              : null),
      child: TextButton(
          onPressed: () {
            storeController.currentFont.value = font;
          },
          child: CorousalText(
            text: styleText,
            color: Colors.white,
            font: font,
          )),
    ));
  }



}


