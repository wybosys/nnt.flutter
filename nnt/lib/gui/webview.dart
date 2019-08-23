part of nnt.gui;

abstract class CWebView extends StatefulWidget with SObject, RefObject {
  CWebView({Key key, this.url, Map ss}) : super(key: key) {
    Instances.push(this);

    signals.connect(kSignalStarting, _cbStarting);
    signals.connect(kSignalStarted, _cbStarted);
    signals.connect(kSignalAbort, _cbAbort);
    signals.connect(kSignalDone, _cbDone);
    signals.connect(kSignalChanged, _cbChanged);

    // 绑定信号实现
    signals.connects(ss);
  }

  // 当前运行的webview副本
  static var Instances = StackedObject<CWebView>();

  void fin() {
    Instances.popAll(this);
    disposeSignals();
  }

  // 执行js代码
  Future<String> eval(String code);

  // 在当前浏览器中执行代码
  Future<String> Eval(String code) {
    var wv = Instances.top();
    if (wv == null) {
      throw Exception('当前环境中没有正在运行的WebView');
    }
    return wv.eval(code);
  }

  // 添加一个交叉对象
  void addJsObj(JsObject obj, String varnm) async {
    var code = jsb.addJsObj(obj, varnm);
    if (code == null) {
      return;
    }

    await eval(code);
    await eval('ptsdk.getDeviceInfo().then(function(res){console.log(res);})');
  }

  // jsb
  JsBridge jsb = new JsBridge();

  // 地址
  String url;

  // 初始化信号
  void initSignals() {
    signals.register(kSignalStarted);
    signals.register(kSignalStarting);
    signals.register(kSignalAbort);
    signals.register(kSignalDone);
    signals.register(kSignalChanged);
    signals.register(kSignalWebViewNewPage);
  }

  void _cbStarting(Slot s) {
    print("准备打开 ${url}");
  }

  void _cbStarted(Slot s) async {
    print("开始打开 ${s.data}");

    if (s.data != url) {
      _stdlibLoaded = false;
      url = s.data;
    }

    if (!_stdlibLoaded) {
      _stdlibLoaded = true;
      await eval(JS_ENVIRONMENT);
      signals.emit(kSignalWebViewNewPage, url);
    }
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
  }

  // 是否已经加载基础库
  bool _stdlibLoaded = false;
}

// 当打开新页面时调用
const kSignalWebViewNewPage = '::nn::webview::newpage';
