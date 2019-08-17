part of nnt.gui;

abstract class GuiApplication extends CoreApplication {
  Future<bool> start() async {
    if (!await super.start()) {
      return false;
    }

    // 显示基础UI
    runApp(Fullscreen());

    return true;
  }

  // 重新定义返回类型
  GuiApplication get shared {
    return super.shared;
  }
}
