part of nnt.gui;

class JsBridge {}

const SCHEME = 'nf20w';

class Message {
  // 对象id
  int objectId;

  // 动作
  String action;

  // 数据
  Map<String, dynamic> params;

  // 序列化和饭序列化
  String serialize() {
    var raw = toJson({'o': objectId, 'a': action, 'p': params});
    raw = Uri.encodeFull(raw);
    return "$SCHEME://$raw";
  }

  void unserialize(String raw) {
    raw = raw.substring(SCHEME.length + 3);
    var obj = toJsonObj(raw);
    objectId = obj['o'];
    action = obj['a'];
    params = obj['p'];
  }
}
