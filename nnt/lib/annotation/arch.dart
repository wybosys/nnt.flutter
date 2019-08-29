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

  // 获得输入的制定位置参数的数据
  dynamic pos(Map params, int idx) {
    var arg = args[idx];
    return params[arg.name];
  }

  // 运行
  dynamic invoke(dynamic obj, Map params) {
    switch (args.length) {
      case 0:
        {
          return instance(obj);
        }
        break;
      case 1:
        {
          return instance(obj, pos(params, 0));
        }
        break;
      case 2:
        {
          return instance(obj, pos(params, 0), pos(params, 1));
        }
        break;
      case 3:
        {
          return instance(obj, pos(params, 0), pos(params, 1), pos(params, 2));
        }
        break;
      case 4:
        {
          return instance(obj, pos(params, 0), pos(params, 1), pos(params, 2),
              pos(params, 3));
        }
        break;
      case 5:
        {
          return instance(obj, pos(params, 0), pos(params, 1), pos(params, 2),
              pos(params, 3), pos(params, 4));
        }
        break;
      case 6:
        {
          return instance(obj, pos(params, 0), pos(params, 1), pos(params, 2),
              pos(params, 3), pos(params, 4), pos(params, 5));
        }
        break;
      case 7:
        {
          return instance(obj, pos(params, 0), pos(params, 1), pos(params, 2),
              pos(params, 3), pos(params, 4), pos(params, 5), pos(params, 6));
        }
        break;
      case 8:
        {
          return instance(
              obj,
              pos(params, 0),
              pos(params, 1),
              pos(params, 2),
              pos(params, 3),
              pos(params, 4),
              pos(params, 5),
              pos(params, 6),
              pos(params, 7));
        }
        break;
      case 9:
        {
          return instance(
              obj,
              pos(params, 0),
              pos(params, 1),
              pos(params, 2),
              pos(params, 3),
              pos(params, 4),
              pos(params, 5),
              pos(params, 6),
              pos(params, 7),
              pos(params, 8));
        }
        break;
    }
  }
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

// Varc('', Map<dynamic, dynamic>, false, false, true)); 会报错
class VarcMap {}

class VarcList {}

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

// dart中 void 不能用来作为类型，所以需要实现一个类代替
class Void {}
