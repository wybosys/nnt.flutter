library nnt.core;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core/status.dart';
part 'core/timer.dart';
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
part 'core/sett.dart';
part 'core/object.dart';
part 'core/storage.dart';
part 'core/udid.dart';
part 'core/asynct.dart';
part 'core/arch.dart';
part 'core/codec.dart';

part 'core.g.dart';

void libCoreInit() {
  _RegisterClazzes();
}
