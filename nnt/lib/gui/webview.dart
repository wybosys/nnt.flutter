part of nnt.gui;

abstract class CWebView extends StatefulWidget with SObject {
  CWebView({Key key, this.url, Map ss}) : super(key: key) {
    signals.connect(kSignalStarting, _cbStarting);
    signals.connect(kSignalStarted, _cbStarted);
    signals.connect(kSignalAbort, _cbAbort);
    signals.connect(kSignalDone, _cbDone);
    signals.connect(kSignalChanged, _cbChanged);

    // 绑定信号实现
    signals.connects(ss);
  }

  // 执行js代码
  Future<bool> eval(String code);

  // 添加一个交叉对象
  void addJsObj(JsObject obj, String varnm) async {
    var code = jsb.addJsObj(obj, varnm);
    if (code == null) {
      return;
    }

    await eval(code);
    await eval('ptsdk.hello("abc").then(function(res){console.log(res);})');
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

  void _cbStarted(Slot s) {
    print("开始打开 ${s.data}");

    if (s.data != url) {
      _stdlibLoaded = false;
      url = s.data;
    }

    if (!_stdlibLoaded) {
      _stdlibLoaded = true;
      eval(JS_ENVIRONMENT);
      signals.emit(kSignalWebViewNewPage, url);
    }
  }

  void _cbAbort(Slot s) {
    print("停止打开 ${s.data}");

    String raw = s.data;
    if (raw.indexOf("${SCHEME}://") == 0) {
      // 收到消息
      var msg = new Message(0, null);
      msg.unserialize(raw);
      String code = jsb.invoke(msg);
      if (code != null) {
        eval(code);
      }
    } else {
      logger.warn("jsb消息头错误: ${raw}");
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
