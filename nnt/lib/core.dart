library nnt.core;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

part 'core/env.dart';
part 'core/application.dart';
part 'core/bundle.dart';
part 'core/clazz.dart';
part 'core/config.dart';
part 'core/default.dart';
part 'core/json.dart';
part 'core/logger.dart';
part 'core/compat.dart';
part 'core/mapt.dart';
part 'core/consts.dart';
part 'core/signals.dart';
part 'core/datetimet.dart';
part 'core/arrayt.dart';
part 'core/objectt.dart';

part 'core.g.dart';

void libCoreInit() {
  _RegisterClazzes();
}
