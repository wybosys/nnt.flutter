part of nnt.annotation;

typedef dynamic FnClazzInstance();

class Clazz {
  // 类名
  String name;

  // 包名
  String library;

  // 类原型
  Type clazz;

  // 构造函数
  FnClazzInstance instance;
}

Map<String, Clazz> _clazzes = new Map();

void RegisterClazz(Clazz clz) {
  _clazzes[clz.name] = clz;
}

Clazz FindClazz(String name) {
  return _clazzes[name];
}
