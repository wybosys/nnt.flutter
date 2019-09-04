part of nnt.gui;

class Fullscreen extends RootWidget {
  @override
  State<StatefulWidget> createState() {
    state = _State();
    return state;
  }
}

class _State extends State<Fullscreen> {
  @override
  void initState() {
    super.initState();

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
