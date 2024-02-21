import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScreen {
  bool _isButtonDisabled = false;
  ScanResult? deviceToConnect;

  // constructor
  BluetoothScreen() {
    var subscription = FlutterBluePlus.onScanResults.listen((results){
        if (results.isNotEmpty) {
          log("BLE APP result is there");
          ScanResult r = results.last; // the most recently found device
          if (r.advertisementData.advName == "DSD TECH") {
            this.deviceToConnect = r;
          }
          print('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        }
      },
      onError: (e) => print(e));
  }


  Future<void> scan() async {
    log('BLE SCAN ENTERED');
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
    _isButtonDisabled = true;
  }

  Future<bool> connect() async {
    if (deviceToConnect != null) {
      await deviceToConnect?.device.connect();
      if(deviceToConnect!.device.isConnected){
        return true;
      }
      else{
        return false;
      }
      // Navigator.of(context).push(_createRoute());
    }
    else{
      return false;
    }
  }

  Future<void> disconnect() async {
    // Disconnect from device
    await deviceToConnect?.device.disconnect();
    // device.disconnect();
    _isButtonDisabled = false;
  }
}