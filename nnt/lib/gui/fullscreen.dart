part of nnt.gui;

class Fullscreen extends RootWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: IS_DEBUG,
        title: 'nnt.flutter',
        home: ContentView());
  }
}
