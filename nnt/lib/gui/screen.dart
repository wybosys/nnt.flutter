part of nnt.gui;

// 屏幕方向
class OrientationType {
  static var AUTOADAPT = 0; // 自适应
  static var PORTRAIT = 1; // 竖屏
  static var LANDSCAPE = 2; // 横屏
}

Future<void> SetOrientationType(int typ) {
  if (typ == OrientationType.LANDSCAPE) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]).then((_) {
      /*if (Platform.isIOS) {
        iOSDevicePlugin.changeScreenOrientation(DeviceOrientation.landscapeLeft);
      }*/
    });
  } else if (typ == OrientationType.PORTRAIT) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      /*if (Platform.isIOS) {
        iOSDevicePlugin.changeScreenOrientation(DeviceOrientation.landscapeLeft);
      }*/
    });
  }
}
