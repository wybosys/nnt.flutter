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
