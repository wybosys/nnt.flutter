library impl.core;

import 'package:flutter/services.dart';
import 'package:nnt/core.dart';

part 'core/channel.dart';
part 'core/system.dart';
part 'core/udid.dart';

void libImplCoreInit() {
  IMP_UDID = ImpUdid;
}
