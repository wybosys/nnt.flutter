import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nnt/gui.dart';
import 'package:nnt/nnt.dart';

class Impl {
  static const MethodChannel _channel = const MethodChannel('impl');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

// 标准应用
class NntApplication extends GuiApplication {
  NntApplication() {
    // 初始化框架
    libNntInit();
  }
}
