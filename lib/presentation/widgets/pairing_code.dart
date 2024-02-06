import 'package:flutter/material.dart';

class PairingCode extends StatelessWidget {
  const PairingCode({super.key});

  // final String currentFont;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        cursorColor: Colors.white,
        style: const TextStyle(
            color: Colors.white,
            // fontFamily: currentFont,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
            enabledBorder: _pairingCodeBorderStyle(),
            focusedBorder: _pairingCodeBorderStyle(),
            suffixIcon: const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.qr_code_2_rounded,
                color: Colors.white,
                size: 50.0,
              ),
            ),

            // constraints: const BoxConstraints(maxWidth: 200.0),
            // labelText: 'Pairing code',
            hintText: 'Pairing code',
            hintStyle: const TextStyle(
                color: Colors.grey,
                // fontFamily: currentFont,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)
        ),
      ),
    );
  }
  OutlineInputBorder _pairingCodeBorderStyle() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    );
  }
}
