library nnt.gui;

import 'package:flutter/material.dart';
import 'package:nnt/core.dart';
import 'package:nnt/annotation.dart';

part 'gui/application.dart';
part 'gui/fullscreen.dart';
part 'gui/webview.dart';
part 'gui/webpage.dart';
part 'gui/jsobject.dart';
part 'gui/jsbridge.dart';
part 'gui/jsbridge.raw.dart';

part 'gui.g.dart';

void libGuiInit() {
  _RegisterClazzes();
}
