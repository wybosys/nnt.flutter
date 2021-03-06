part of nnt.gui;

class JsBridge {
  // 添加一个js实例，返回需要浏览器运行的代码
  String addJsObj(JsObject obj, String varnm, [bool tmp = false]) {
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
    if (tmp) {
      if (tpl_tmpvar == null) {
        tpl_tmpvar = new Template(TPL_TMP_VARIABLE);
      }
      codes.add(tpl_tmpvar.renderString(
          {'name': varnm, 'clazz': clz.name, 'objid': obj.objectId}));
    } else {
      if (tpl_var == null) {
        tpl_var = new Template(TPL_VARIABLE);
      }
      codes.add(tpl_var.renderString(
          {'name': varnm, 'clazz': clz.name, 'objid': obj.objectId}));
    }

    return codes.length != 0 ? codes.join(';\n') : null;
  }

  static Template tpl_clazz;
  static Template tpl_var;
  static Template tpl_tmpvar;

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
        List<String> args = [];
        List<String> params = [];
        if (e.args != null && e.args.length > 0) {
          e.args.forEach((e) {
            args.add(e.name);
            params.add('"${e.name}": ${e.name}');
          });
        }
        return {
          'name': e.name,
          'args': args.join(','),
          'params': "{${params.join(',')}}"
        };
      })
    });

    return code;
  }

  // 调用本地函数，并返回需要web运行的code
  Future<String> invoke(Message msg) async {
    if (!_jsobjects.containsKey(msg.objectId)) {
      logger.warn("没有找到jsb中设置的对象 ${msg.objectId}");
      return null;
    }

    var jsobj = _jsobjects[msg.objectId];
    var clz = ClazzOfName(jsobj.className);
    if (!clz.funcs.containsKey(msg.action)) {
      logger.warn("没有找到jsb中对象的方法 ${jsobj.className}:${msg.action}");
      return null;
    }

    // 执行函数
    Func func = clz.funcs[msg.action];

    // 附加的需要执行的js代码
    List<String> codes = [];

    try {
      dynamic ret;
      if (func.ret.async) {
        ret = await func.invoke(jsobj, msg.params);
      } else {
        ret = func.invoke(jsobj, msg.params);
      }

      // 需要将ret抓换成标准map对象
      if (ret != null) {
        if (!IsPod(ret)) {
          if (ret is ToObject) {
            ret = ret.toObject();
          } else if (ret is JsObject) {
            // 返回值变成全局变量
            var varnm = "ret_${ret.objectId}";
            codes.add(addJsObj(ret, varnm, true));

            // 回调全局变量
            msg.mode = MESSAGEMODETYPE_VAR;
            ret = "nnt.flutter.tmp.$varnm";
          } else {
            // 判断是否可以转成json
            var t = toJson(ret, null);
            if (t == null) {
              throw new Exception('无法将返回值转换为js标准对象');
            }
          }
        }
      } else {
        ret = {};
      }

      // 放回成功消息
      msg.params = {'ok': ret};
    } catch (err) {
      String info;
      if (err is PlatformException) {
        info = "jsb捕获异常 ${err.code} ${err.message}";
      } else {
        info = "jsb捕获异常 ${err.toString()}";
      }
      logger.warn(info);

      // 放回失败消息
      msg.params = {
        'err': {'msg': info, 'code': STATUS.EXCEPTION}
      };
    }

    codes.add('''nnt.flutter.jsb.result("${msg.serialize()}");''');

    return codes.join(';');
  }

  // 当前保存的jsobj
  Map<int, JsObject> _jsobjects = new Map();

  // 当前已经加入的类
  Map<String, bool> _clazzloaded = new Map();
}

// 协议头
const SCHEME = 'nf20w';

// 用于app/js间交换消息

const MESSAGEMODETYPE_EMPTY = 0; // 空
const MESSAGEMODETYPE_EVAL = 1; // 执行ok返回的语句
const MESSAGEMODETYPE_VAR = 2; // ok返回的是全局变量名

class Message {
  Message(this.objectId, this.action, [this.params]);

  // 对象id
  int objectId;

  // 消息id
  int id;

  // 动作
  String action;

  // 类型
  int mode = MESSAGEMODETYPE_EMPTY;

  // 数据
  Map<String, dynamic> params;

  // 序列化和饭序列化
  String serialize() {
    var raw = toJson({
      'o': objectId,
      'a': action,
      'p': (params != null ? params : {}),
      'i': id,
      'm': mode
    });
    raw = Uri.encodeFull(raw);
    return "$SCHEME://$raw";
  }

  void unserialize(String raw) {
    raw = raw.substring(SCHEME.length + 3);
    raw = Uri.decodeFull(raw);
    var obj = toJsonObj(raw);
    objectId = obj['o'];
    action = obj['a'];
    params = obj['p'];
    id = obj['i'];
    mode = obj['m'];
  }
}
