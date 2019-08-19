library nnt;

import 'package:nnt/cli.dart';
import 'package:nnt/core.dart';
import 'package:nnt/gui.dart';
import 'package:nnt/test.dart';

part 'nnt.g.dart';

// 框架初始化
void libNntInit() {
  libCoreInit();
  libCliInit();
  libGuiInit();
  libTestInit();
}

// 标准应用
class NntApplication extends GuiApplication {
  NntApplication() {
    // 初始化框架
    libNntInit();
  }
}
