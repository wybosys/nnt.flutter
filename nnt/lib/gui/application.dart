library nnt.gui;

import 'package:flutter/material.dart';
import 'package:nnt/core/application.dart';

import 'fullscreen.dart';

abstract class GuiApplication extends CoreApplication {
  Future<void> start() {
    runApp(Fullscreen());
  }
}
