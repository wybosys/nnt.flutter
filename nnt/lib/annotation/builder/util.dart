part of nnt.annotation.builder;

// 不能引入nnt其他高级别的库，builder为通过flutter run独立运行在控制台中
V AvaMap<K, V>(Map<K, V> m, K k, [V def = null]) {
  if (m.containsKey(k)) return m[k];
  m[k] = def;
  return def;
}
