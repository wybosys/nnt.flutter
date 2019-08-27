part of impl.gui;

class WebViewU extends CWebView {
  WebViewU({Key key, String url, String userAgent, Map ss})
      : super(key: key, url: url, ss: ss, userAgent: userAgent);

  @override
  State<StatefulWidget> createState() => _State();

  @override
  Future<String> eval(String code) async {
    String res = await _self.evalJavascript(code);
    logger.log("webviewjs: $res");
    return res;
  }

  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();
}

class _State extends State<WebViewU> {
  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    _self.close();

    _self.onStateChanged.listen((viewState) {
      switch (viewState.type) {
        case WebViewState.startLoad:
          widget.emit(kSignalStarted, viewState.url);
          break;
        case WebViewState.shouldStart:
          widget.emit(kSignalStarting, viewState.url);
          break;
        case WebViewState.finishLoad:
          widget.emit(kSignalDone, viewState.url);
          break;
        case WebViewState.abortLoad:
          widget.emit(kSignalAbort, viewState.url);
          break;
      }
    });

    _self.onUrlChanged.listen((url) {
      widget.emit(kSignalChanged, url);
    });
  }

  bool clearCache = true;
  bool appCacheEnabled = false;

  @override
  void dispose() {
    super.dispose();
    _self.dispose();
    widget.fin();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        key: widget.key,
        url: widget.url,
        invalidUrlRegex: "^${SCHEME}://.*",
        userAgent: '',
        clearCache: clearCache,
        appCacheEnabled: appCacheEnabled);
  }
}
