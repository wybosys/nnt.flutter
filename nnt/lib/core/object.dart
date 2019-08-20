part of nnt.core;

int _hashCode = 0;

mixin HashObject {
  final int hashCode = ++_hashCode;
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

mixin SObject on RefObject {
  Signals _signals;

  @override
  dispose() {
    super.dispose();
    if (_signals != null) {
      _signals.dispose();
      _signals = null;
    }
  }

  Signals get signals {
    if (_signals == null) {
      _signals = new Signals(this);
    }
    return _signals;
  }
}
