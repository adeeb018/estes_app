import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final StoreController storeController = Get.put(StoreController());


  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'estes',
      home: HomePage(),
    );
  }
}

