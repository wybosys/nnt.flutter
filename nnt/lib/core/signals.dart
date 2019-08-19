part of nnt.core;

// 用于穿透整个emit流程的对象
class SlotTunnel {
  /** 是否请求中断了emit过程 */
  bool veto;

  /** 附加数据 */
  dynamic payload;
}

typedef void FnSlotCallback(dynamic s);

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
}
