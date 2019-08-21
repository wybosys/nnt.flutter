part of nnt.annotation.builder;

// 不能引入nnt其他高级别的库，builder为通过flutter run独立运行在控制台中
dynamic AvaMap<K>(Map<K, dynamic> m, K k, [dynamic def = null]) {
  if (m.containsKey(k)) return m[k];
  m[k] = def;
  return def;
}

String toJson(dynamic obj, [String def = '']) {
  if (obj is String) {
    return obj;
  }
  if (obj is Map) {
    try {
      return json.encode(obj);
    } catch (err) {
      return def;
    }
  }
  return def;
}
