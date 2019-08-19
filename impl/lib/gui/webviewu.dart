part of impl.gui;

class WebViewU extends WebView with CWebView {
  WebViewU({Key key, this.url})
      : super(
            key: key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: url);

  String url;
}
