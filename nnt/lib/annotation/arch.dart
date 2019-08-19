part of nnt.annotation;

typedef dynamic FnClazzInstance();

// 用于注册的类描述
class Clazz {
  // 类名
  String name;

  // 包名
  String library;

  // 类原型
  Type proto;

  // 构造函数
  FnClazzInstance instance;

  // 类全名
  String get fullname {
    return "${library}.${name}";
  }
}

// 短名称
Map<String, Clazz> _clazzes = new Map();

// 注册类
void RegisterClazz(Clazz clz) {
  var nm = clz.name;
  if (_clazzes.containsKey(nm)) {
    print("遇到重名类 ${nm}");
    return;
  }

  _clazzes[nm] = clz;
  _clazzes[clz.fullname] = clz;

  print("注册类 ${nm}");
}

// 查找类描述
Clazz FindClazz(String name) {
  return _clazzes[name];
}
