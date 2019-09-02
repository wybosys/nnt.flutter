part of nnt.core;

typedef Future<String> FnDeviceId();

class DeviceIdentifier {
  String idfa;
  String imei;
  String mac;
  String androidid;
}

class Device {
  static FnDeviceId IMP_IDFA;
  static FnDeviceId IMP_IMEI;
  static FnDeviceId IMP_MAC;
  static FnDeviceId IMP_ANDROIDID;

  static Future<String> GetIdfa() {
    return IMP_IDFA();
  }

  static Future<String> GetImei() {
    return IMP_IMEI();
  }

  static Future<String> GetMac() {
    return IMP_MAC();
  }

  static Future<String> GetAndroidId() {
    return IMP_ANDROIDID();
  }

  // 获得系统中所有标识
  static Future<DeviceIdentifier> AllIdentifier() async {
    var r = DeviceIdentifier();
    r.idfa = await IMP_IDFA();
    r.imei = await IMP_IMEI();
    r.mac = await IMP_MAC();
    r.androidid = await IMP_ANDROIDID();
    return r;
  }
}
