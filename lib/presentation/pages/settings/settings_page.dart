import 'dart:developer';
import 'dart:io';

import 'package:estes_app/core/controllers/theme_border_provider.dart';
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

  Widget _themeContainers() {
    return Consumer<ThemeBorderProvider>(
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

  Padding _themeHeading() {
    return const Padding(
      padding: EdgeInsets.only(left: 25.0, top: 80),
      child: Text(
        'Add a Background Image',
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  Widget _themeButtons(int index,ThemeBorderProvider dataProvider) {
    int themeVal = index + 1;
          return GestureDetector(
            onTap: () {
              for (ImageContainers imageContainer in imageContainers) {
                imageContainer.selectedContainer = false;
              }
              storeController.currentTheme.value = themeVal;
              if (imageContainers[index].type) {
                if(imageContainers[index].storageType){
                  storeController.currentBackgroundPath.value = imageContainers[index].imagePath!;
                }
                storeController.currentBackground = imageContainers[index].imageName!; // problem here
                imageContainers[index].selectedContainer = true;
                Provider.of<ThemeBorderProvider>(context, listen: false).changeBorderSelected(index + 1);
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
        Provider.of<ThemeBorderProvider>(context, listen: false).changeGridLength(imageContainers.length + 1);
      }

      // _loadImageContainersList();
      // setState(() {
      //
      // });
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
}