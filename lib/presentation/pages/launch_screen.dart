import 'package:estes_app/presentation/widgets/appBar.dart';
import 'package:estes_app/presentation/widgets/corousal_text_style.dart';
import 'package:flutter/material.dart';

class LaunchRocket extends StatefulWidget {
  const LaunchRocket({super.key});

  // final String currentFont;
  @override
  State<LaunchRocket> createState() => _LaunchRocketState();
}

class _LaunchRocketState extends State<LaunchRocket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/launch_rocket.png'),
            const SizedBox(
              height: 50,
              child: CorousalText(text: 'Hold on rocket\nfor 5 Seconds to launch',color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
