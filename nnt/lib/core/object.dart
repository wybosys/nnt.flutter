part of nnt.core;

int _objectCounter = 0;

mixin CounterObject {
  final int objectId = ++_objectCounter;
}

mixin RefObject {
  int _refcount = 1;

  void dispose() {
    // pass
  }

  void drop() {
    if (--_refcount == 0) {
      dispose();
    }
  }

  void grab() {
    if (_refcount > 0) {
      ++_refcount;
    }
  }
}

class SObject {
  // 信号实例
  Signals _signals;

  // 初始化信号
  void initSignals() {
    // pass
  }

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
