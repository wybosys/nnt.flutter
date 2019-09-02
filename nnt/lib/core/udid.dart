part of nnt.core;

typedef FutureOr<String> FnUdid();

List<FnUdid> _imps = [];

void RegisterUdidImp(FnUdid imp) {
  _imps.add(imp);
}

// 通过多种方式获得UDID编码
String UDID() {
  String v = null;

  // 一个方法一个方法的来，最后将所有方法获得udid汇总到一起，做md5digest
  AsyncT.AllThen(_imps).then((res) {
    // 合并所有字符串
    String s = res.join('/');
    v = MD5(s);
  });

  while (v == null) {
    sleep(Duration(milliseconds: 1));
  }

  return v;
}
