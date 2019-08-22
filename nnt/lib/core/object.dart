part of nnt.core;

int _objectCounter = 0;

mixin CounterObject {
  final int objectId = ++_objectCounter;
}

mixin RefObject {
  int _refcount = 1;

  // 析够
  void fin();

  // 释放计数
  void drop() {
    if (--_refcount == 0) {
      fin();
    }
  }

  // 增加技术
  void grab() {
    if (_refcount > 0) {
      ++_refcount;
    }
  }
}

abstract class SObject {
  // 信号实例
  Signals _signals;

  // 初始化信号
  void initSignals();

  // 释放
  void disposeSignals() {
    if (_signals != null) {
      _signals.dispose();
      _signals = null;
    }
  }

  Signals get signals {
    if (_signals == null) {
      _signals = new Signals(this);
      initSignals();
    }
    return _signals;
  }

  // 带保护的激发
  void emit(String sig, [dynamic d = null, SlotTunnel tunnel = null]) {
    if (_signals != null) {
      _signals.emit(sig, d, tunnel);
    }
  }
}

abstract class ToJsonObj {
  // 转换到json对象
  Map<String, dynamic> toJsonObj();
}

class StackedObject<T> {
  void push(T obj) {
    __objs.add(obj);
  }

  T pop() {
    return __objs.removeLast();
  }

  void popAll(T obj) {
    __objs.removeWhere((e) => e == obj);
  }

  T top([T def = null]) {
    if (__objs.length == 0) return def;
    return __objs.last;
  }

  List<T> __objs = new List();
}
