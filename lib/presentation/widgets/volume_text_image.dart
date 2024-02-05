import 'package:flutter/material.dart';
class VolumeToMax extends StatelessWidget {
  const VolumeToMax({super.key,required this.currentTheme});

  final int currentTheme;
  @override
  Widget build(BuildContext context) {
      if(currentTheme == 1) {
        return Image.asset('assets/images/sound_image_1.png');
      } else {
        return SizedBox();
      }
  }
}
