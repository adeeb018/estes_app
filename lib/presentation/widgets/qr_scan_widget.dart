import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:get/get.dart';

import '../../core/controllers/getx_controller.dart';

class QrScreen extends StatelessWidget {
  QrScreen({super.key});

  final StoreController storeController = Get.find<StoreController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            iconSize: 30),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
              child: ReaderWidget(
                showToggleCamera: false,
                showGallery: false,
                onScan: (code) async {
                  storeController.paringTextController.value.text = code.text!;
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
    )
    );
  }
}

