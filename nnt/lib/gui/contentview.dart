part of nnt.gui;

class ContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GuiApplication.shared.rootWidget.mediaQueryData = MediaQuery.of(context);
    return GuiApplication.shared.clazzHome.instance();
  }
}
