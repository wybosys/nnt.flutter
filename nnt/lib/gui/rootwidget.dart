part of nnt.gui;

abstract class RootWidget extends StatelessWidget {
  RootWidget() {
    // 隐藏电池栏
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  MediaQueryData mediaQueryData;
}
