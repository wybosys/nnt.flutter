part of nnt.gui;

abstract class CWebView extends StatefulWidget with SObject {
  CWebView({Key key, this.url}) : super(key: key) {
    signals.connect(kSignalStarting, _cbStarting, this);
    signals.connect(kSignalStarted, _cbStarted, this);
    signals.connect(kSignalAbort, _cbAbort, this);
    signals.connect(kSignalDone, _cbDone, this);
    signals.connect(kSignalChanged, _cbChanged, this);
  }

  // 执行js代码
  Future<bool> eval(String code);

  // 添加一个交叉对象
  void addObject(JsObject obj);

  // 地址
  String url;

  // 初始化信号
  void initSignals() {
    signals.register(kSignalStarted);
    signals.register(kSignalStarting);
    signals.register(kSignalAbort);
    signals.register(kSignalDone);
    signals.register(kSignalChanged);
  }

  void _cbStarting(Slot s) {
    if (s.data != url) {
      _stdlibLoaded = false;
      url = s.data;
    }

    if (!_stdlibLoaded) {
      _stdlibLoaded = true;
      eval(JS_ENVIRONMENT);
    }

    print("准备打开 ${url}");
  }

  void _cbStarted(Slot s) {
    print("开始打开 ${s.data}");
  }

  void _cbAbort(Slot s) {
    print("停止打开 ${s.data}");
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
