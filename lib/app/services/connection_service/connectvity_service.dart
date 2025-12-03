import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;



  void dispose() {
    _subscription?.cancel();
  }
}
