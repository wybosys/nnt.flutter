part of nnt.gui;

abstract class CWebView {
  // 执行js代码
  Future<bool> eval(String code);

  // 添加一个交叉对象
  void addObject(JsObject obj);

  // 当前的路径
  String url;

  Signals get signals;

  // 初始化信号
  void initSignals() {
    signals.register(kSignalStarted);
    signals.register(kSignalStarting);
    signals.register(kSignalAbort);
    signals.register(kSignalDone);
    signals.register(kSignalChanged);

    signals.connect(kSignalStarting, _cbStarting, this);
    signals.connect(kSignalStarted, _cbStarted, this);
    signals.connect(kSignalAbort, _cbAbort, this);
    signals.connect(kSignalDone, _cbDone, this);
    signals.connect(kSignalChanged, _cbChanged, this);
  }

  void _cbStarted(Slot s) {}

  void _cbStarting(Slot s) {
    if (s.data != url) {
      _libraryloaded = false;
      url = s.data;
    }

    if (!_libraryloaded) {
      _libraryloaded = true;
      eval(JS_ENVIRONMENT);
    }

    print("准备打开 ${url}");
  }

  void _cbAbort(Slot s) {}

  void _cbDone(Slot s) {}

  void _cbChanged(Slot s) {
    print("跳转 ${url}");
  }

  // 是否已经加载基础库
  bool _libraryloaded;
}
