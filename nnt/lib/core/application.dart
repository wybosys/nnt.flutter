part of nnt.core;

abstract class CoreApplication {
  static var $__shared;

  CoreApplication() {
    $__shared = this;
    logger.log('应用启动');
  }

  // 获得全局对象
  static CoreApplication get shared {
    return $__shared;
  }

  // 启动游戏
  Future<bool> start() async {
    return await loadConfig();
  }

  // 读取配置文件
  Future<bool> loadConfig() async {
    var cfg = await bundle.json(fileConfig, null);
    if (cfg == null) {
      logger.fatal("没有找到应用配置 $fileConfig");
      return false;
    }
    // 读取文件的设置到全局设置
    config.override(cfg);

    logger.log('应用配置加载完成');
    return true;
  }

  // 默认配置文件路径
  String fileConfig = 'assets/app.json';

  // 当前配置
  Config config = Config();
}
