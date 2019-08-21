part of impl.gui;

class WebViewU extends WebviewScaffold with SObject, CWebView {
  WebViewU({Key key, String url}) : super(key: key, url: url) {
    _self.onStateChanged.listen((viewState) async {
      switch (viewState.type) {
        case WebViewState.startLoad:
          emit(kSignalStarting, viewState.url);
          break;
        case WebViewState.shouldStart:
          emit(kSignalStarted, viewState.url);
          break;
        case WebViewState.finishLoad:
          emit(kSignalDone, viewState.url);
          break;
        case WebViewState.abortLoad:
          emit(kSignalAbort, viewState.url);
          break;
      }
    });
    _self.onUrlChanged.listen((url) {
      emit(kSignalChanged, url);
    });
  }

  // 全局单件
  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();

  // 执行js代码
  Future<bool> eval(String code) async {
    String res = await _self.evalJavascript(code);
    logger.log("webviewjs: $res");
    return res != null;
  }

  // 添加一个交叉对象
  void addObject(JsObject obj) {}
}
