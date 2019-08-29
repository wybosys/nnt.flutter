part of nnt.gui;

abstract class GuiApplication extends CoreApplication {
  // 返回Gui的单件
  static GuiApplication get shared {
    return CoreApplication.$__shared;
  }

  // 启动
  Future<bool> start() async {
    if (!await super.start()) {
      return false;
    }

    // 设置方向
    var ori = config.getValueByKeyPath('app.orientation', 0);
    SetOrientationType(ori);

    // 初始化根
    Fullscreen root = new Fullscreen();

    // 显示基础UI
    runApp(root);

    return true;
  }

  // 读取配置
  Future<bool> loadConfig() async {
    if (!await super.loadConfig()) {
      return false;
    }

    // 检查配置文件信息
    var clz = config.getValueByKeyPath('home.entry');
    if (clz == null) {
      logger.fatal('没有配置默认页面 home.entry');
      return false;
    }
    clazzHome = ClazzOfName(clz);
    if (clazzHome == null) {
      logger.fatal('没有找到类 $clz');
      return false;
    }

    return true;
  }

  // 根页面类型
  Clazz clazzHome;
}
