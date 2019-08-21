part of nnt.annotation;

typedef dynamic FnClazzInstance();

// 用于注册的成员描述
class Func {
  Func([this.name, this.instance, this.args, this.ret]);

  // 函数名
  String name;

  // 参数表
  List<Varc> args;

  // 返回数据
  Varc ret;

  // 函数实体
  Function instance;
}

typedef dynamic FnVarGet(dynamic obj);
typedef void FnVarSet(dynamic obj);

class Varc {
  Varc(
      [this.name,
      this.type,
      this.readonly = false,
      this.optional = false,
      this.async = false]);

  // 变量名
  String name;

  // 变量类型
  Type type;

  // 只读
  bool readonly;

  // 可选
  bool optional;

  // 异步处理
  bool async;
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
