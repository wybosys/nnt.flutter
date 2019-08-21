part of nnt.gui;

class JsBridge {
  // 添加一个js实例，返回需要浏览器运行的代码
  String addJsObj(JsObject obj, String varnm) {
    if (_jsobjects.containsKey(obj.objectId)) {
      return null;
    }
    _jsobjects[obj.objectId] = obj;

    List<String> codes = [];

    // 构造类
    var code = codeClazz(obj);
    if (code != null) {
      codes.add(code);
    }

    // 实例化对象
    var clz = ClazzOfName(obj.className);
    if (tpl_var == null) {
      tpl_var = new Template(TPL_VARIABLE);
    }
    codes.add(tpl_var.renderString(
        {'name': varnm, 'clazz': clz.name, 'objid': obj.objectId}));

    return codes.length != 0 ? codes.join(';\n') : null;
  }

  static Template tpl_clazz;
  static Template tpl_var;

  // 生成类的代码
  String codeClazz(JsObject obj) {
    if (_clazzloaded.containsKey(obj.className)) {
      // 已经加载
      return null;
    }
    _clazzloaded[obj.className] = true;

    // 找到对象的定义类
    var clz = ClazzOfName(obj.className);
    if (clz == null) {
      logger.fatal("没有找到该对象的类定义 ${obj.className}");
      return null;
    }

    // 通过app和js间的消息通讯达到rpc的目的
    if (tpl_clazz == null) {
      tpl_clazz = new Template(TPL_CLAZZ);
    }
    var code = tpl_clazz.renderString({
      'clazz': clz.name,
      'funcs': ArrayT.Convert(clz.funcs.values.toList(), (Func e, i) {
        return {'name': e.name};
      })
    });

    return code;
  }

  // 当前保存的jsobj
  Map<int, JsObject> _jsobjects = new Map();

  // 当前已经加入的类
  Map<String, bool> _clazzloaded = new Map();
}

const SCHEME = 'nf20w';

class Message {
  // 对象id
  int objectId;

  // 动作
  String action;

  // 数据
  Map<String, dynamic> params;

  // 序列化和饭序列化
  String serialize() {
    var raw = toJson(
        {'o': objectId, 'a': action, 'p': (params != null ? params : {})});
    raw = Uri.encodeFull(raw);
    return "$SCHEME://$raw";
  }

  void unserialize(String raw) {
    raw = raw.substring(SCHEME.length + 3);
    var obj = toJsonObj(raw);
    objectId = obj['o'];
    action = obj['a'];
    params = obj['p'];
  }
}
