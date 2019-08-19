part of nnt.gui;

class Fullscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: IS_DEBUG,
        title: 'nnt.flutter',
        home: GuiApplication.shared.clazzHome.instance());
  }
}
