library app;

import 'package:flutter/material.dart';
import 'package:nnt/annotation.dart';
import 'package:impl/gui.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'app/home.dart';
part 'app.g.dart';

void libAppInit() {
  _RegisterClazzes();
}
