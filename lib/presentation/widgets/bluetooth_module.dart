import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';
class BluetoothScreen1 {
  ScanResult? deviceToConnect;
  Set<ScanResult> set = {};
  // constructor
  BluetoothScreen1() {
    var subscription = FlutterBluePlus.onScanResults.listen((results){
      if (results.isNotEmpty) {
        // log("BLE APP result is there");
        ScanResult r = results.last; // the most recently found device
        // for (var r in results) {
        set.add(r);
        // }
        // if (r.advertisementData.advName == "DSD TECH") {
        //   deviceToConnect = r;
        //   // log('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
        // }

      }
    },
        onError: (e) => log(e));

    FlutterBluePlus.cancelWhenScanComplete(subscription);
  }


  Future<void> scan() async {
    log('BLE SCAN ENTERED');
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
  }

  Future<bool> connect() async {
    // if (deviceToConnect != null) {
    //   try{
    //     await deviceToConnect?.device.connect();
    //   }
    //   on FlutterBluePlusException catch(e){
    //     log('Connect Error is ${e.code}');
    //     if(e.code == 133){
    //       connect();
    //       return true;
    //     }
    // }
    //   if(deviceToConnect!.device.isConnected){
    //     return true;
    //   }
    //   else{
    //     log('BLE APP not connected try again');
    //     return false;
    //   }
    //   // Navigator.of(context).push(_createRoute());
    // }
    // else{
    //   log('BLE APP not connected try again');
    //   return false;
    // }
    List<Map<String,String>> jsonList = [];// = set.toList();
    // String jsonResult = jsonEncode(list);
    String jsonResult;
    int i=0;
    for (ScanResult element in set) {
      // jsonString.add('{"Mac_ID":"${element.device.remoteId}", "advertisementName":"${element.advertisementData.advName}"}');
      Map<String,String> myMap = {"MacId":"${element.device.remoteId}", "advertisementName":element.advertisementData.advName};
      jsonList.add(myMap);
      // print(i);
    }
    Map<String,List> finalMap = {"deviceList":jsonList};

    String jsonString = jsonEncode(finalMap);
    debugPrint(jsonString,wrapWidth: 500);
    // jsonResult = jsonString[0];
    // debugPrint(jsonResult,wrapWidth: 500);
    // String jsonResult = jsonEncode(list);
    // print(jsonResult);

    return true;
  }

  Future<void> disconnect() async {
    // Disconnect from device
    await deviceToConnect?.device.disconnect();
    // device.disconnect();
    log("BLE APP Disconnected");
  }

  Future<void> buttonAction(List<int> writeList) async {
    List<BluetoothService>? services =
    await deviceToConnect?.device.discoverServices();
    services?.forEach((service) async {
      // do something with service
      // Reads all characteristics
      var characteristics = service.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        // Writes to a characteristic
        // print(characteristics);
        if(characteristics[0].serviceUuid.str == 'ffe0'){
          await c.write(writeList);
        }
      }
    });
  }
}