part of nnt.annotation;

typedef dynamic FnClazzInstance();

// 用于注册的成员描述
class Func {
  Func([this.name, this.instance]);

  // 函数名
  String name;

  // 函数实体
  Function instance;
}

typedef dynamic FnVarGet(dynamic obj);
typedef void FnVarSet(dynamic obj);

class Varc {
  Varc([this.name, this.getval, this.setval]);

  // 变量名
  String name;

  // 获得和设置数据
  FnVarGet getval;
  FnVarSet setval;
}

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

  // 成员描述
  Map<String, Func> funcs = new Map();
  Map<String, Varc> vars = new Map();
}

// 短名称
Map<String, Clazz> _clazzes = new Map();

// 映射类对象到类描述
Map<Type, Clazz> _protos = new Map();

// 注册类
void RegisterClazz(Clazz clz) {
  var nm = clz.name;
  if (_clazzes.containsKey(nm)) {
    print("遇到重名类 ${clz.fullname}");
    return;
  }

  _clazzes[nm] = clz;
  _clazzes[clz.fullname] = clz;
  _protos[clz.proto] = clz;

  // print("注册类 ${nm}");
}

// 查找类描述
Clazz ClazzOfName(String name) {
  return _clazzes.containsKey(name) ? _clazzes[name] : null;
}

Clazz ClazzOfType(Type clz) {
  return _protos.containsKey(clz) ? _protos[clz] : null;
}
