part of nnt.gui;

class JsBridge {
  bool addJsObj(JsObject obj) {
    if (_jsobjects.containsKey(obj.objectId)) {
      return false;
    }

    _jsobjects[obj.objectId] = obj;
    return true;
  }

  static Template tpl_clazz;

  String jscode(JsObject obj) {
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
