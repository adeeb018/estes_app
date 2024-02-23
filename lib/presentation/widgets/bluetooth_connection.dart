import 'dart:developer';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScreen {
  ScanResult? deviceToConnect;

  // constructor
  BluetoothScreen() {
    var subscription = FlutterBluePlus.onScanResults.listen((results){
        if (results.isNotEmpty) {
          log("BLE APP result is there");
          ScanResult r = results.last; // the most recently found device
          if (r.advertisementData.advName == "DSD TECH") {
            deviceToConnect = r;
            log('${r.device.remoteId}: "${r.advertisementData.advName}" found!');
          }

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

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5), withServices:[Guid("180D")],
      withNames:["DSD TECH"]);

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
  }

  Future<bool> connect() async {
    if (deviceToConnect != null) {
      deviceToConnect?.device.connect();
      if(deviceToConnect!.device.isConnected){
        return true;
      }
      else{
        log('BLE APP not connected try again');
        return false;
      }
      // Navigator.of(context).push(_createRoute());
    }
    else{
      log('BLE APP not connected try again');
      return false;
    }
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