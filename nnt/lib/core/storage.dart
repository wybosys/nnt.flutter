part of nnt.core;

class _Storage {
  SharedPreferences __hdl = null;

  FutureOr<SharedPreferences> _hdl() async {
    if (__hdl != null) {
      return __hdl;
    }

    return await SharedPreferences.getInstance();
  }

  Future<bool> clear() async {
    return (await _hdl()).clear();
  }

  Future<void> reload() async {
    return (await _hdl()).reload();
  }

  Future<bool> remove(String key) async {
    return (await _hdl()).remove(key);
  }

  Future<bool> setBool(String key, bool val) async {
    return (await _hdl()).setBool(key, val);
  }

  FutureOr<bool> getBool(String key, [bool def = false]) async {
    try {
      return (await _hdl()).getBool(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  Future<bool> setInt(String key, int val) async {
    return (await _hdl()).setInt(key, val);
  }

  FutureOr<int> getInt(String key, [int def = 0]) async {
    try {
      return (await _hdl()).getInt(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  Future<bool> setDouble(String key, double val) async {
    return (await _hdl()).setDouble(key, val);
  }

  FutureOr<double> getDouble(String key, [double def = 0]) async {
    try {
      return (await _hdl()).getDouble(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  Future<bool> setString(String key, String val) async {
    return (await _hdl()).setString(key, val);
  }

  FutureOr<String> getString(String key, [String def = '']) async {
    try {
      return (await _hdl()).getString(key);
    } catch (e) {
      // pass
    }
    return def;
  }

  FutureOr<bool> containesKey(String key) async {
    return (await _hdl()).containsKey(key);
  }
}

final storage = new _Storage();
