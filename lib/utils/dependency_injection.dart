import 'package:flutter_pyday/network/index.dart';

enum DataMode { DART, JSON }

//DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static DataMode _dataMode;

  static void configure(DataMode dataMode) {
    _dataMode = dataMode;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  IClient get currentClient {
    return RestClient();
  }

  DataMode get currentDataMode {
    switch (_dataMode) {
      case DataMode.DART:
        return DataMode.DART;
      case DataMode.JSON:
        return DataMode.JSON;
      default:
        return DataMode.DART;
    }
  }
}
