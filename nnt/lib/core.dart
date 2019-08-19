library nnt.core;

import 'dart:convert';

import 'package:flutter/services.dart';

part 'core/application.dart';
part 'core/bundle.dart';
part 'core/clazz.dart';
part 'core/config.dart';
part 'core/default.dart';
part 'core/json.dart';
part 'core/logger.dart';
part 'core/object.dart';
part 'core/compat.dart';
part 'core/mapt.dart';
part 'core/consts.dart';

part 'core.g.dart';

void libCoreInit() {
  _RegisterClazzes();
}
