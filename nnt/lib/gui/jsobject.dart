part of nnt.gui;

// 用于webview和flutter之间建立可以直接调用的桥梁，例如一个jsobject如果js实现了方法，dart可以直接调用，dart的数据成员，js可以直接赋值，同一个jsobj实例模糊掉是js或者dart实现

class JsObject with CounterObject {
  JsObject(this.className);

  // 映射jsobj需要可以从对象获得类名
  final String className;
}
