

import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

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
      'storageType': storageType,
    };
  }

  factory ImageContainers.fromJson(Map<String, dynamic> json) {
    return ImageContainers(
      type: json['type'] ?? false,
      // Providing a default value in case type is missing
      imageName: json['imageName'],
      imagePath: json['imagePath'],
      selectedContainer: json['selectedContainer'] ?? false,
      storageType: json['storageType']?? false,
    );
  }
}


class SaveOrLoadImageFromSP{
  static loadImageContainersList(String sharedPreferenceName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(sharedPreferenceName);

    if (jsonString != null) {
      List<dynamic> mappedList = jsonDecode(jsonString);
      List<ImageContainers> imageContainersList =
      mappedList.map((map) => ImageContainers.fromJson(map)).toList();
      return imageContainersList;
    } else {
      log('SHARED PREFERENCE LOAD ERROR');
    }
  }

  static saveImageContainersList(List<ImageContainers> list,String sharedPreferenceName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Convert the list of ImageContainers to a list of maps
    List<Map<String, dynamic>> mappedList =
    list.map((container) => container.toJson()).toList();
    String jsonString = jsonEncode(mappedList);
    await prefs.setString(sharedPreferenceName, jsonString);
  }
}


