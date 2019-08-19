part of nnt.core;

class MapT {
  /** 根据查询路径获取值 */
  static dynamic GetValueByKeyPath(Map o, String kp, [dynamic def = null]) {
    if (o == null) {
      return def;
    }
    var ks = kp.split('.');
    var r = any_cast(o);
    for (var i = 0; i < ks.length; ++i) {
      r = r[ks[i]];
      if (r == null) return def;
    }
    return r;
  }

  static dynamic GetValueByKeyPaths(Map o, List<String> ks,
      [dynamic def = null]) {
    if (o == null) {
      return def;
    }
    var r = any_cast(o);
    for (var i = 0; i < ks.length; ++i) {
      r = r[ks[i]];
      if (r == null) return def;
    }
    return r;
  }

  /** 根据查询路径设置值 */
  static bool SetValueByKeyPath(Map o, String kp, dynamic v) {
    if (o == null) {
      print("不能对null进行keypath的设置操作");
      return false;
    }
    final ks = kp.split('.');
    final l = ks.length - 1;
    var r = any_cast(o);
    for (var i = 0; i < l; ++i) {
      var k = ks[i];
      var t = any_cast(r[k]);
      if (t == null) {
        t = {};
        r[k] = t;
      }
      r = t;
    }
    r[ks[l]] = v;
    return true;
  }

  static bool SetValueByKeyPaths(Map o, dynamic v, List<String> ks) {
    if (o == null) {
      print("不能对null进行keypath的设置操作");
      return false;
    }
    final l = ks.length - 1;
    var r = any_cast(o);
    for (var i = 0; i < l; ++i) {
      var k = ks[i];
      var t = any_cast(r[k]);
      if (t == null) {
        t = {};
        r[k] = t;
      }
      r = t;
    }
    r[ks[l]] = v;
    return true;
  }

  // 展开成keypath的结构
  static Map KeyPathExpand(Map o) {
    var r = {};
    _KeyPathExpandAt(o, r, []);
    return r;
  }

  static void _KeyPathExpandAt(dynamic o, Map r, List<String> p) {
    if (IsPod(o)) {
      r[p.join('.')] = o;
      return;
    }

    if (o is List) {
      for (var i = 0, l = o.length; i < l; ++l) {
        var np = List.of(p);
        np.add(i.toString());
        _KeyPathExpandAt(o[i], r, np);
      }
    } else if (o is Map) {
      o.forEach((e, k) {
        var np = List.of(p);
        np.add(k);
        _KeyPathExpandAt(e, r, np);
      });
    } else {
      print('遇到不支持的数据类型');
    }
  }
}
