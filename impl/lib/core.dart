library impl.core;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nnt/core.dart';

part 'core/channel.dart';
part 'core/system.dart';
part 'core/udid.dart';
part 'core/device.dart';

void libImplCoreInit() {
  // 获取设备id
  IMP_UDID = ImpUdid;

  // 获取识别码实现
  Device.IMP_ANDROIDID = ImpGetAndroidId;
  Device.IMP_IDFA = ImpGetIdfa;
  Device.IMP_IMEI = ImpGetImei;
  Device.IMP_MAC = ImpGetMac;
}
