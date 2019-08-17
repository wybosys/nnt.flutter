part of nnt.core;

Map<String, dynamic> toJsonObj(dynamic obj, [Map def = NULL_MAP]) {
  if (obj is Map) {
    return obj;
  }
  if (obj is String) {
    try {
      return json.decode(obj);
    } catch (err) {
      return def;
    }
  }
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
