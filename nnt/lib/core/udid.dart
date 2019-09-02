part of nnt.core;

typedef FutureOr<String> FnUdid();

FnUdid IMP_UDID = null;

// 通过多种方式获得UDID编码
Future<String> UDID() async {
  return IMP_UDID();
}
