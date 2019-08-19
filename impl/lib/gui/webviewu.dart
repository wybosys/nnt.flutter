part of impl.gui;

class WebViewU extends WebviewScaffold with CWebView {
  WebViewU({Key key, this.url}) : super(key: key, url: url);

  // 访问地址
  String url;
}
