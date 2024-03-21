
import 'dart:io';
// import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

import 'image_path_and_name.dart';

class UploadImage{
  static Future<ImagePathAndName?> getImage() async {
    final permissionStatus = await Permission.manageExternalStorage.request();

    if(permissionStatus.isGranted){
      log('PERMISSION GRANTED');
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedFile != null){
        log('PICKED THE FILE');
        final directory = await getExternalStorageDirectory();

        if(directory != null){
          String imagePath = '${directory.path}/${pickedFile.name}';
          await File(pickedFile.path).copy(imagePath);


          log('IMAGE PATH RETURNED');
          return ImagePathAndName(imagePath: imagePath, imageName: pickedFile.name);
        }
      }
    }
    return null;
  }
}