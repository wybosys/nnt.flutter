part of nnt.core;

abstract class CoreApplication {
  static CoreApplication _shared;

  CoreApplication() {
    _shared = this;
    logger.log('应用启动');
  }

  // 启动游戏
  Future<void> start();

  // 当前配置
  Config config = Config();
}
