part of nnt.gui;

class Fullscreen extends StatelessWidget {
  Fullscreen() {
    // 隐藏电池栏
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: IS_DEBUG,
        title: 'nnt.flutter',
        home: GuiApplication.shared.clazzHome.instance());
  }
}
