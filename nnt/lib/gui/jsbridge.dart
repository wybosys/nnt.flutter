part of nnt.gui;

class JsBridge {
  // 基础jsb运行环境
  static String Environment() {
    return JS_ENVIRONMENT;
  }

  // 生成运行在浏览器中的类对象
  static String CodeForClazz(Clazz clz) {}
}
