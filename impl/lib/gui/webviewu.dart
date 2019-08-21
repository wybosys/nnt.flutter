part of impl.gui;

class WebViewU extends WebviewScaffold with SObject, CWebView {
  WebViewU({Key key, this.url})
      : super(key: key, url: url, invalidUrlRegex: "${SCHEME}://") {
    _self.onStateChanged.listen((viewState) async {
      switch (viewState.type) {
        case WebViewState.startLoad:
          {
            emit(kSignalStarting, viewState.url);

            if (viewState.url != url) {
              _libraryloaded = false;
              url = viewState.url;
            }

            if (!_libraryloaded) {
              _libraryloaded = true;
              eval(JS_ENVIRONMENT);
            }

            print("准备打开 ${viewState.url}");
          }
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
      print("跳转 ${url}");
    });
  }

  // 是否已经加载基础库
  bool _libraryloaded;

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

  // 访问地址
  String url;
}
