import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatus {
  static ConnectivityStatus _instance = ConnectivityStatus();

  static ConnectivityStatus getInstance() {
    return _instance;
  }

  _ConnectivityStatus() {}

  Future<bool> isDeviceOnline() async {
    var connectivityResult = await(Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
