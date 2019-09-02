part of nnt.core;

abstract class CoreApplication {
  static var $__shared;

  CoreApplication() {
    $__shared = this;
    logger.log('应用启动');

    // 初始化基础设置
    config.override({
      TOOLKIT_AUTHOR: "wybosys@gmail.com",
      TOOLKIT_LICENSE: "BSD",
      TOOLKIT_REPO: "github.com/wybosys/nnt.game.h5",
      VERSION: '1.0.0'
    });
  }

  // 获得全局对象
  static CoreApplication get shared {
    return $__shared;
  }

  // 获取设备唯一id

  // 启动游戏
  Future<bool> start() async {
    if (!await loadConfig()) {
      return false;
    }

    // 读取基础设置
    IS_DEBUG = config.getValueByKeyPath('app.debug', false);
    if (IS_DEBUG) print('DEBUG模式');
    IS_RELEASE = !IS_DEBUG;
    if (IS_RELEASE) print('RELEASE模式');

    return true;
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
