part of nnt.core;

typedef Future<String> FnDeviceId();

class Device {
  static FnDeviceId IMP_IDFA;
  static FnDeviceId IMP_IMEI;
  static FnDeviceId IMP_MAC;
  static FnDeviceId IMP_ANDROIDID;
}
