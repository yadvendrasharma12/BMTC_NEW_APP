import 'dart:async';
import 'package:bmtc_app/app/utils/toast_message.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetChecker {
  late StreamSubscription subscription;
  bool isAlertShown = false;

  void startListening(BuildContext context) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {

      final result = results.first;

      if (result == ConnectivityResult.none) {
        if (!isAlertShown) {
          AppToast.showError(
            context,
            "Please check internet connection",
          );
          isAlertShown = true;
        }
      } else {
        if (isAlertShown) {
          AppToast.showSuccess(
            context,
            "Internet back",
          );
          isAlertShown = false;
        }
      }
    });
  }

  void dispose() {
    subscription.cancel();
  }
}
