part of nnt.core;

class _Storage {
  SharedPreferences __hdl = null;

  SharedPreferences _hdl() {
    if (__hdl != null) {
      return __hdl;
    }
    SharedPreferences.getInstance().then((obj) {
      __hdl = obj;
    });
    while (__hdl == null) {
      sleep(Duration(milliseconds: 1));
    }
    return __hdl;
  }

  Future<bool> clear() {
    return _hdl().clear();
  }

  Future<void> reload() {
    return _hdl().reload();
  }

  Future<bool> remove(String key) {
    return _hdl().remove(key);
  }

  Future<bool> setBool(String key, bool val) {
    return _hdl().setBool(key, val);
  }

  FutureOr<bool> getBool(String key, [bool def = false]) {
    try {
      return _hdl().getBool(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  Future<bool> setInt(String key, int val) {
    return _hdl().setInt(key, val);
  }

  FutureOr<int> getInt(String key, [int def = 0]) {
    try {
      return _hdl().getInt(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  Future<bool> setDouble(String key, double val) {
    return _hdl().setDouble(key, val);
  }

  FutureOr<double> getDouble(String key, [double def = 0]) {
    try {
      return _hdl().getDouble(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  Future<bool> setString(String key, String val) {
    return _hdl().setString(key, val);
  }

  FutureOr<String> getString(String key, [String def = '']) {
    try {
      return _hdl().getString(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  FutureOr<bool> containesKey(String key) {
    return _hdl().containsKey(key);
  }
}

final storage = new _Storage();
