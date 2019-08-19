part of nnt.core;

final JSTYPE_MAP = {
  int: 'number',
  double: 'number',
  bool: 'boolean',
  String: 'string'
};

// 兼容js的类型检查
String typeof(dynamic obj) {
  if (obj == null) return 'object';
  final rt = obj.runtimeType;
  if (JSTYPE_MAP.containsKey(rt)) return JSTYPE_MAP[rt];
  return 'object';
}

bool IsPod(dynamic obj) {
  if (obj == null) return false;
  final rt = obj.runtimeType;
  return rt == int || rt == double || rt == bool || rt == String;
}

dynamic any_cast(dynamic obj) {
  // dart会默认推导类型，将导致不同类型赋值时抛出类型不匹配的异常，先设置为null可以破坏这个过程
  var r = null;
  r = obj;
  return r;
}
