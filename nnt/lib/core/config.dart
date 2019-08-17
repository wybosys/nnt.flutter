part of nnt.core;

// 应用配置
class Config {
  void override(Map obj) {
    obj.forEach((k, v) {
      _cur[k] = v;
    });
  }

  dynamic get(String key, [dynamic def = null]) {
    return _cur.containsKey(key) ? this._cur[key] : def;
  }

  void set(String key, dynamic val) {
    _cur[key] = val;
  }

  void delete(String key) {
    if (_cur.containsKey(key)) {
      _cur.remove(key);
    }
  }

  bool contains(String key) {
    return _cur.containsKey(key);
  }

  Map<String, dynamic> _cur = {};
}
