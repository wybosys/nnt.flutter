import 'dart:async';

import 'package:flutter/services.dart';

class Impl {
  static const MethodChannel _channel = const MethodChannel('impl');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
