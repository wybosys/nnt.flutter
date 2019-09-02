import 'package:impl/core.dart';
import 'package:nnt/gui.dart';
import 'package:nnt/nnt.dart';

// 标准应用
class NntApplication extends GuiApplication {
  NntApplication() {
    libNntInit();
    libImplInit();
  }
}

void libImplInit() {
  libImplCoreInit();
}
