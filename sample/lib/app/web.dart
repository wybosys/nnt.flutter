part of app;

@clazz()
class MyWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebViewU(
      url: 'https://bing.com',
    );
  }
}
