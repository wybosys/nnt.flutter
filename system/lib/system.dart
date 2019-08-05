import 'dart:async';

import 'package:flutter/services.dart';

class System {
  static const MethodChannel _channel =
      const MethodChannel('system');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
