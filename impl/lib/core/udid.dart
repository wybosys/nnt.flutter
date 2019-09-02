part of impl.core;

Future<String> ImpUdid() async {
  return await channel.invokeMethod('getUdid');
}
