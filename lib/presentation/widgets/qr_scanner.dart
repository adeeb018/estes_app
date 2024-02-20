// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// class QrScreen extends StatelessWidget {
//   const QrScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mobile Scanner')),
//       body: MobileScanner(
//         // fit: BoxFit.contain,
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;
//           for (final barcode in barcodes) {
//             debugPrint('Barcode found! ${barcode.rawValue}');
//           }
//         },
//       ),
//     );
//   }
// }
