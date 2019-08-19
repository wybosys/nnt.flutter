part of nnt.gui;

class Fullscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'nnt.flutter', home: GuiApplication.shared.clazzHome.instance());
  }
}
