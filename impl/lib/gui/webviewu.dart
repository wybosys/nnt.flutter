part of impl.gui;

class WebViewU extends WebviewScaffold with CWebView {
  WebViewU({Key key, this.url}) : super(key: key, url: url);

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
