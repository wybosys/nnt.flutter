part of nnt.gui;

abstract class GuiApplication extends CoreApplication {
  Future<void> start() {
    runApp(Fullscreen());
  }
}
