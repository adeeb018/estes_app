import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:estes_app/presentation/widgets/appbar_widget.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';
import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/background_image_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class ImageContainers {
  ///bool type false for add button and bool type true for normal image container
  final bool type;
  final String? imageName;
  final String? imagePath;
  bool selectedContainer;

  /// storage type false for assetImage storage type and true for File image
  bool storageType;

  ImageContainers(
      {required this.type,
      this.imageName,
      this.imagePath,
      this.selectedContainer = false,
      this.storageType = false});

  // Convert ImageContainers object to a map
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'imageName': imageName,
      'imagePath': imagePath,
      'selectedContainer': selectedContainer,
    };
  }

  factory ImageContainers.fromJson(Map<String, dynamic> json) {
    return ImageContainers(
      type: json['type'] ?? false,
      // Providing a default value in case type is missing
      imageName: json['imageName'],
      imagePath: json['imagePath'],
      selectedContainer: json['selectedContainer'] ?? false,
    );
  }
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
    _LoadImageData();
    super.initState();
  }

  _LoadImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the value with the given key exists in shared preferences
    bool containsValue = prefs.containsKey('imageList');

    if (containsValue) {
      //if anything present on shared preference then copy it in to imageContainer object by clearing all of the data in it.
      imageContainers.clear();
      imageContainers = [..._loadImageContainersList()];
    } else {
      //convert imageNames list to json and add to sharedPreferences.
      _saveImageContainersList(imageContainers);
      log('SHARED PREFERENCE initialized');
    }
  }

  _loadImageContainersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('imageContainersList');

    if (jsonString != null) {
      List<dynamic> mappedList = jsonDecode(jsonString);
      List<ImageContainers> imageContainersList =
          mappedList.map((map) => ImageContainers.fromJson(map)).toList();
      return imageContainersList;
    } else {
      log('SHARED PREFERENCE LOAD ERROR');
    }
  }

  _saveImageContainersList(List<ImageContainers> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the list of ImageContainers to a list of maps
    List<Map<String, dynamic>> mappedList =
        list.map((container) => container.toJson()).toList();
    String jsonString = jsonEncode(mappedList);
    await prefs.setString('imageContainersList', jsonString);
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
        child: Stack(
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
        ),
      ),
    );
  }

  Widget _themeContainers() {
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
          return _themeButtons(index);
        },
      ),
    );
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

  Widget _themeButtons(int index) {
    int themeVal = index + 1;
    return GestureDetector(
      onTap: () {
        for (ImageContainers imageContainer in imageContainers) {
          imageContainer.selectedContainer = false;
        }
        storeController.currentTheme.value = themeVal;
        if (imageContainers[index].type) {
          storeController.currentBackground = imageContainers[index].imageName!;
          imageContainers[index].selectedContainer = true;
        }
      },
      child: Container(
          decoration: BoxDecoration(
            image: _imageOrAddFile(index),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: _borderSelectedContainer(index),
          ),
          child: _addNewTheme(index),
        ),
    );
  }


  DecorationImage? _imageOrAddFile(int index) {
    if (imageContainers[index].type) {
      return DecorationImage(image: _loadImage(index), fit: BoxFit.fill);
    }
    return null;
  }

  Border? _borderSelectedContainer(int index) {
    if (imageContainers[index].selectedContainer) {
      return Border.all(
        color: Colors.pinkAccent, // border color on selection
        width: 2.0,
      );
    }
    return null;
  }

  Widget? _addNewTheme(int index) {
    if (imageContainers[index].type == false) {
      return const Center(
        child: Icon(
          Icons.add_circle_outline_rounded,
          ///////////////// for the last container we add a '+' icon to its center.
          color: Colors.white,
          size: 50,
        ),
      );
    }
    return null;
  }

  _loadImage(int index) {
    if (imageContainers[index].storageType) {
      return FileImage(File(imageContainers[index].imagePath!));
    }
    return AssetImage(
        imageContainers[index].imagePath ?? 'assets/images/first_screen.png');
  }
}
