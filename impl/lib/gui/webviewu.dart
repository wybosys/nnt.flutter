part of impl.gui;

class WebViewU extends CWebView {
  WebViewU({Key key, String url, String userAgent})
      : super(key: key, url: url, userAgent: userAgent) {}

  @override
  State<StatefulWidget> createState() => WebViewStateU();

  @override
  Future<String> eval(String code) async {
    String res = await _self.evalJavascript(code);
    logger.log("webviewjs: $res");
    return res;
  }

  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();
}

class WebViewStateU<T extends WebViewU> extends CWebViewState<T> {
  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();

  WebViewStateU() {
    logger.log("实例化一个新的WebViewState");
  }

  @override
  void initState() {
    super.initState();
    logger.log("初始化WebViewState");
    _self.close();

    _self.onStateChanged.listen((viewState) {
      switch (viewState.type) {
        case WebViewState.startLoad:
          signals.emit(kSignalStarted, viewState.url);
          break;
        case WebViewState.shouldStart:
          signals.emit(kSignalStarting, viewState.url);
          break;
        case WebViewState.finishLoad:
          signals.emit(kSignalDone, viewState.url);
          break;
        case WebViewState.abortLoad:
          signals.emit(kSignalAbort, viewState.url);
          break;
      }
    });

    _self.onUrlChanged.listen((url) {
      signals.emit(kSignalChanged, url);
    });
  }

  bool clearCache = true;
  bool appCacheEnabled = false;

  @override
  void dispose() {
    super.dispose();
    _self.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        key: widget.key,
        url: widget.url,
        invalidUrlRegex: "^${SCHEME}://.*",
        userAgent: widget.userAgent,
        clearCache: clearCache,
        appCacheEnabled: appCacheEnabled);
  }

  @override
  Future<String> eval(String code) {
    return _self.evalJavascript(code);
  }
}
