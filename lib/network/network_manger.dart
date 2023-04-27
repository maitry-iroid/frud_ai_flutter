import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  var connectionType = 0.obs;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  // @override
  // void onInit() {
  //   getConnectionType();
  //   _streamSubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateState);
  // }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult!);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;

        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;

        break;
      case ConnectivityResult.none:
        connectionType.value = 0;

        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}
