import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/presentation/pages/home_page.dart';
import 'package:estes_app/presentation/widgets/theme_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.style1,
      darkTheme: ThemeClass.style2,
      title: 'estes',
      home: const HomePage(),
    );
  }
}

