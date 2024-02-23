import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key,required this.carouselController});

  final CarouselController carouselController;
  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin{
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    lottieController = AnimationController(vsync: this,duration: const Duration(milliseconds: 1500));

    lottieController.forward();

    lottieController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        log("LOTTIE STATUS Completed");
        widget.carouselController.nextPage();
        Get.back();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Lottie.asset('assets/animations/loading_animation_1.json',controller: lottieController)
      ),
    );
  }
}
