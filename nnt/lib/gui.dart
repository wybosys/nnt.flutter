library nnt.gui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nnt/core.dart';
import 'package:nnt/annotation.dart';
import 'package:reflected_mustache/mustache.dart';

part 'gui/application.dart';
part 'gui/fullscreen.dart';
part 'gui/webview.dart';
part 'gui/webpage.dart';
part 'gui/jsobject.dart';
part 'gui/jsbridge.dart';
part 'gui/jsbridge.raw.dart';
part 'gui/jsbridge.tpl.dart';
part 'gui/screen.dart';
part 'gui/rootwidget.dart';

part 'gui.g.dart';

void libGuiInit() {
  _RegisterClazzes();
}
