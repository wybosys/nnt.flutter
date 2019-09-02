part of impl.core;

Future<String> ImpGetIdfa() {
  var c = Completer();
  c.complete('');
  return c.future;
}

Future<String> ImpGetMac() async {
  return await channel.invokeMethod('getMAC');
}

Future<String> ImpGetImei() async {
  return await channel.invokeMethod('getIMEI');
}

Future<String> ImpGetAndroidId() async {
  return await channel.invokeMethod('getANDROIDID');
}
