library nnt.core;

import 'logger.dart';

abstract class CoreApplication {
  static CoreApplication _shared;

  CoreApplication() {
    _shared = this;
    logger.log('应用启动');
  }

  // 启动游戏
  Future<void> start();
}
