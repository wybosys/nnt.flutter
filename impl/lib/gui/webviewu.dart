part of impl.gui;

class WebViewU extends CWebView {
  WebViewU({Key key, String url, Map ss}) : super(key: key, url: url, ss: ss) {
    _self.onStateChanged.listen((viewState) async {
      switch (viewState.type) {
        case WebViewState.startLoad:
          emit(kSignalStarted, viewState.url);
          break;
        case WebViewState.shouldStart:
          emit(kSignalStarting, viewState.url);
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

  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();

  @override
  State<StatefulWidget> createState() => _State();

  @override
  Future<bool> eval(String code) async {
    String res = await _self.evalJavascript(code);
    logger.log("webviewjs: $res");
    return res != null;
  }
}

class _State extends State<WebViewU> {
  final FlutterWebviewPlugin _self = new FlutterWebviewPlugin();

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
        invalidUrlRegex: "r'^${SCHEME}://.*'");
  }
}
