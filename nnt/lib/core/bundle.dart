part of nnt.core;

class Bundle {
  Bundle(this._cur);

  Future<String> string(String path, [String def = '']) async {
    try {
      return await rootBundle.loadString(path);
    } catch (err) {
      return def;
    }
  }

  Future<Map<String, dynamic>> json(String path, [Map def = NULL_MAP]) async {
    var str = await string(path, null);
    if (str == null) {
      return def;
    }
    return toJsonObj(str, def);
  }

  Future<ByteData> image(String path, [ByteData def = null]) async {
    return rootBundle.load(path);
  }

  AssetBundle _cur;
}

Bundle bundle = Bundle(rootBundle);
