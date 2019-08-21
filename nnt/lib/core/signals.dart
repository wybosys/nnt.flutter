part of nnt.core;

// 用于穿透整个emit流程的对象
class SlotTunnel {
  /** 是否请求中断了emit过程 */
  bool veto;

  /** 附加数据 */
  dynamic payload;
}

typedef void FnSlotCallback(Slot s);

// 插槽对象
class Slot {
  /** 重定向的信号 */
  String redirect;

  /** 回调 */
  FnSlotCallback cb;

  /** 回调的上下文 */
  dynamic target;

  /** 激发者 */
  dynamic sender;

  /** 数据 */
  dynamic data;

  /** 延迟s启动 */
  double delay = 0;

  /** 穿透用的数据 */
  SlotTunnel tunnel;

  /** connect 时附加的数据 */
  dynamic payload;

  /** 信号源 */
  String signal;

  /** 激发频率限制 (emits per second) */
  double eps = 0;
  int _epstms;

  /** 是否中断掉信号调用树 */
  bool _veto;
  bool get veto {
    return _veto;
  }

  set veto(bool b) {
    _veto = b;
    if (tunnel != null) {
      tunnel.veto = b;
    }
  }

  /** 调用几次自动解绑，默认为 null，不使用概设定 */
  int count;
  int emitedCount = 0;

  dispose() {
    cb = null;
    target = null;
    sender = null;
    data = null;
    payload = null;
    tunnel = null;
  }

  /** 激发信号
      @d 附带的数据，激发后自动解除引用 */
  void emit(dynamic d, SlotTunnel t) {
    if (eps != 0) {
      var now = DateTimeT.Now();
      if (_epstms == null) {
        _epstms = now;
      } else {
        var el = now - _epstms;
        //_epstms = now; 注释以支持快速多次点击中可以按照频率命中一次，而不是全部都忽略掉
        if ((1000 / el) > eps) {
          return;
        }
        _epstms = now; //命中一次后重置时间
      }
    }

    data = d;
    tunnel = t;

    if (delay > 0) {
      Delay(delay, () {
        _doEmit();
      });
    } else {
      _doEmit();
    }
  }

  _doEmit() {
    if (target != null) {
      if (cb != null) {
        cb(this);
      } else if (redirect != null && target.signals) {
        target.signals.emit(redirect, data);
      }
    } else if (cb != null) {
      cb(this);
    }

    data = null;
    tunnel = null;

    ++emitedCount;
  }
}

class Slots {
  // 保存所有插槽
  List<Slot> slots = [];

  // 所有者，会传递到 Slot 的 sender
  dynamic owner;

  // 信号源
  String signal;

  void dispose() {
    clear();
    owner = null;
  }

  /** 清空连接 */
  void clear() {
    ArrayT.Clear(slots, (o) {
      o.dispose();
    });
  }

  /** 阻塞信号
    @note emit被阻塞的信号将不会有任何作用 */
  int _block = 0;

  void block() {
    _block += 1;
  }

  void unblock() {
    _block -= 1;
  }

  /** 是否已经阻塞 */
  bool isblocked() {
    return _block != 0;
  }

  /** 添加一个插槽 */
  void add(Slot s) {
    slots.add(s);
  }

  /** 对所有插槽激发信号
      @note 返回被移除的插槽的对象
   */
  Set<dynamic> emit(dynamic data, SlotTunnel tunnel) {
    if (isblocked()) {
      return null;
    }

    List<int> ids;
    ArrayT.Foreach(slots, (Slot o, int idx) {
      if (o.count != null && o.emitedCount >= o.count) {
        return true;
      }

      o.signal = signal;
      o.sender = owner;
      o.emit(data, tunnel);

      if (o.count != null && o.emitedCount >= o.count) {
        if (ids == null) ids = [];
        ids.add(idx);
        return true;
      }

      return !o.veto;
    });

    if (ids != null) {
      Set<dynamic> r = new Set();
      ArrayT.RemoveObjectsInIndexArray(slots, ids).forEach((o) {
        if (o.target != null) {
          r.add(o.target);
        }
        o.dispose();
      });
      return r;
    }

    return null;
  }

  bool disconnect(FnSlotCallback cb, dynamic target) {
    var rmd = ArrayT.RemoveObjectsByFilter(slots, (Slot o, idx) {
      if (cb != null && o.cb != cb) {
        return false;
      }
      if (o.target == target) {
        o.dispose();
        return true;
      }
      return false;
    });
    return rmd.length != 0;
  }

  Slot find_connected_function(FnSlotCallback cb, dynamic target) {
    return ArrayT.QueryObject(slots, (Slot s, idx) {
      return s.cb == cb && s.target == target;
    });
  }

  Slot find_redirected(String sig, dynamic target) {
    return ArrayT.QueryObject(slots, (Slot s, idx) {
      return s.redirect == sig && s.target == target;
    });
  }

  bool is_connected(dynamic target) {
    return ArrayT.QueryObject(slots, (Slot s, idx) {
          return s.target == target;
        }) !=
        null;
  }
}

abstract class SignalsDelegate {
  void _signalConnected(String sig, Slot s);
}

class Signals {
  Signals(this.owner);

  Map<String, Slots> _slots = new Map();

  // 信号的主体
  dynamic owner;

  // 监听信号
  SignalsDelegate delegate;

  // 反向登记，当自身 dispose 时，需要和对方断开
  Set<Signals> __invtargets = new Set<Signals>();

  Set<String> _castings;

  // 析构
  void dispose() {
    // 反向断开连接
    SetT.Clear(__invtargets, (o) {
      if (o.owner && o.owner._signals)
        o.owner._signals.disconnectOfTarget(owner, false);
    });

    // 清理信号，不能直接用clear的原因是clear不会断开对于ower的引用
    MapT.Clear(_slots, (Slots o, String k) {
      if (o != null) {
        o.dispose();
      }
    });

    owner = null;
    delegate = null;
    _castings = null;
  }

  void clear() {
    // 清空反向的连接
    SetT.Clear(__invtargets, (o) {
      if (o.owner && o.owner._signals)
        o.owner._signals.disconnectOfTarget(owner, false);
    });

    // 清空slot的连接
    MapT.Foreach(_slots, (Slots o, k) {
      if (o != null) {
        o.clear();
      }
    });
  }

  /** 注册信号 */
  bool register(String sig) {
    if (sig == null) {
      logger.warn("不能注册一个空信号");
      return false;
    }

    if (_slots.containsKey(sig)) {
      return false;
    }

    _slots[sig] = null;
    return true;
  }

  Slots _avaslots(String sig) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return null;
    }

    var ss = _slots[sig];
    if (ss == null) {
      ss = new Slots();
      ss.signal = sig;
      ss.owner = owner;
      _slots[sig] = ss;
    }
    return ss;
  }

  /** 只连接一次 */
  Slot once(String sig, FnSlotCallback cb, dynamic target) {
    var r = connect(sig, cb, target);
    r.count = 1;
    return r;
  }

  /** 连接信号插槽 */
  Slot connect(String sig, FnSlotCallback cb, dynamic target) {
    var ss = _avaslots(sig);
    if (ss == null) {
      logger.warn("对象信号 " + sig + " 不存在");
      return null;
    }

    Slot s = ss.find_connected_function(cb, target);
    if (s != null) {
      return s;
    }

    s = new Slot();
    s.cb = cb;
    s.target = target;
    ss.add(s);

    if (delegate != null) {
      delegate._signalConnected(sig, s);
    }

    __inv_connect(target);
    return s;
  }

  /** 该信号是否存在连接上的插槽 */
  bool isConnected(String sig) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return false;
    }

    var ss = _slots[sig];
    return ss != null && ss.slots.length != 0;
  }

  /** 激发信号 */
  void emit(String sig, [dynamic d = null, SlotTunnel tunnel = null]) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return;
    }

    var ss = _slots[sig];
    if (ss != null) {
      var targets = ss.emit(d, tunnel);
      if (targets != null) {
        // 收集所有被移除的target，并断开反向连接
        targets.forEach((target) {
          if (isConnectedOfTarget(target) == false) {
            __inv_disconnect(target);
          }
        });
      }
    }
  }

  /** 向外抛出信号
      @note 为了解决诸如金币变更、元宝变更等大部分同时发生的事件但是因为set的时候不能把这些的修改函数合并成1个函数处理，造成同一个消息短时间多次激活，所以使用该函数可以在下一帧开始后归并发出唯一的事件。所以该函数出了信号外不支持其他带参
   */
  void cast(String sig) {
    if (_castings == null) {
      _castings = new Set<String>();
      Delay(0, () => _doCastings());
    }
    _castings.add(sig);
  }

  void _doCastings() {
    if (_castings == null) return;
    _castings.forEach((sig) {
      emit(sig);
    });
    _castings = null;
  }

  /** 断开连接 */
  void disconnectOfTarget(dynamic target, [bool inv = true]) {
    if (target == null) {
      return;
    }

    MapT.Foreach(_slots, (ss, k) {
      if (ss != null) {
        ss.disconnect(null, target);
      }
    });

    if (inv) {
      __inv_disconnect(target);
    }
  }

  /** 断开连接 */
  void disconnect(String sig,
      [FnSlotCallback cb = null, dynamic target = null]) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return;
    }

    var ss = _slots[sig];
    if (ss == null) {
      return;
    }

    if (cb == null && target == null) {
      // 清除sig的所有插槽，自动断开反向引用
      var targets = new Set<dynamic>();
      ArrayT.Clear(ss.slots, (Slot o) {
        if (o.target) targets.add(o.target);
        o.dispose();
      });
      targets.forEach((target) {
        if (!isConnectedOfTarget(target)) __inv_disconnect(target);
      });
    } else {
      // 先清除对应的slot，再判断是否存在和target相连的插槽，如过不存在，则断开反向连接
      if (ss.disconnect(cb, target) && target && !isConnectedOfTarget(target)) {
        __inv_disconnect(target);
      }
    }
  }

  bool isConnectedOfTarget(dynamic target) {
    return MapT.QueryObject(_slots, (ss, k) {
          return ss ? ss.is_connected(target) : false;
        }) !=
        null;
  }

  /** 阻塞一个信号，将不响应激发 */
  void block(String sig) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return;
    }

    Slots ss = _slots[sig];
    if (ss != null) {
      ss.block();
    }
  }

  void unblock(String sig) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return;
    }

    Slots ss = _slots[sig];
    if (ss != null) {
      ss.unblock();
    }
  }

  bool isblocked(String sig) {
    if (!_slots.containsKey(sig)) {
      logger.warn("对象信号 " + sig + " 不存在");
      return false;
    }

    Slots ss = _slots[sig];
    if (ss != null) {
      return ss.isblocked();
    }
    return false;
  }

  void __inv_connect(dynamic tgt) {
    if (tgt == null || tgt.signals == null) {
      return;
    }
    if (tgt.signals == this) {
      return;
    }
    tgt.signals.__invtargets.add(this);
  }

  void __inv_disconnect(dynamic tgt) {
    if (tgt == null || tgt.signals == null) {
      return;
    }
    if (tgt.signals == this) {
      return;
    }
    tgt.signals.__invtargets.delete(this);
  }
}

const kSignalStarting = '::nn::starting';
const kSignalStarted = '::nn::started';
const kSignalAbort = '::nn::abort';
const kSignalDone = '::nn:done';
const kSignalChanged = '::nn::changed';
