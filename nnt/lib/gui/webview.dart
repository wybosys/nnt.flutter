part of nnt.gui;

abstract class CWebView extends StatefulWidget {
  CWebView({Key key, this.url, this.userAgent}) : super(key: key) {
    logger.log("实例化一个新的WebView");
  }

  String url;
  String userAgent;
}

abstract class CWebViewState<T extends CWebView> extends State<T> with SObject {
  CWebViewState() {
    signals.connect(kSignalStarting, _cbStarting);
    signals.connect(kSignalStarted, _cbStarted);
    signals.connect(kSignalAbort, _cbAbort);
    signals.connect(kSignalDone, _cbDone);
    signals.connect(kSignalChanged, _cbChanged);
  }

  // 初始化信号
  void initSignals() {
    signals.register(kSignalStarted);
    signals.register(kSignalStarting);
    signals.register(kSignalAbort);
    signals.register(kSignalDone);
    signals.register(kSignalChanged);
  }

  void dispose() {
    super.dispose();
    disposeSignals();
  }

  // 添加一个交叉对象
  Future<void> addJsObj(JsObject obj, String varnm) async {
    var code = jsb.addJsObj(obj, varnm);
    if (code == null) {
      return;
    }

    await eval(code);
    // await eval('ptsdk.getDeviceInfo().then(function(res){console.log(res);})');
  }

  Future<void> addJsClazz(JsObject obj) async {
    var code = jsb.codeClazz(obj);
    if (code == null) {
      return;
    }

    await eval(code);
  }

  // 执行js代码
  Future<String> eval(String code);

  // 加载标准库
  void _loadStdLib() async {
    // 添加默认执行环境
    await eval(JS_EMBEDED);
  }

  // jsb
  JsBridge jsb = new JsBridge();

  void _cbStarting(Slot s) {
    print("准备打开 ${s.data}");
  }

  void _cbStarted(Slot s) async {
    print("开始打开 ${s.data}");
  }

  void _cbAbort(Slot s) async {
    String raw = s.data;
    if (raw.indexOf("${SCHEME}://") == 0) {
      print("收到jsb调用 ${s.data}");

      // 收到消息
      var msg = new Message(0, null);
      msg.unserialize(raw);
      String code = await jsb.invoke(msg);
      if (code != null) {
        await eval(code);
      }
    } else {
      print("中止打开 ${s.data}");
    }
  }

  void _cbDone(Slot s) {
    print("已经打开 ${s.data}");
  }

  void _cbChanged(Slot s) {
    print("跳转 ${s.data}");
    _loadStdLib();
  }
}
