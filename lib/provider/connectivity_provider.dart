import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:surge_global/enums/connectivity_status.dart';

class ConnectivityProvider {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityProvider() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //convert result to enum
      var connectionStatus = _getStatusFromResult(result);

      //Emit stream
      connectionStatusController.add(connectionStatus);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;

      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;

      case ConnectivityResult.none:
        return ConnectivityStatus.offline;

      default:
        return ConnectivityStatus.offline;
    }
  }
}
