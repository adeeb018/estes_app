import 'package:estes_app/core/controllers/getx_controller.dart';
import 'package:estes_app/core/controllers/theme_border_provider.dart';
import 'package:estes_app/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider<ThemeBorderProvider>(
        create: (context) => ThemeBorderProvider(),
        child: Consumer<ThemeBorderProvider>(
            builder: (context, themeProvider, child) => const GetMaterialApp(
                  debugShowCheckedModeBanner: true,
                  title: 'estes',
                  home: WelcomeWidget(),
                  // builder: EasyLoading.init(),
                )));
  }
}
