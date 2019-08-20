part of nnt.gui;

abstract class CWebView {
  // 执行js代码
  Future<bool> eval(String code);

  // 添加一个交叉对象
  void addObject(JsObject obj);
}
