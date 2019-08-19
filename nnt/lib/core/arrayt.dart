part of nnt.core;

class ArrayT {
  static void Foreach<T>(List<T> arr, bool proc(T e, int idx)) {
    if (arr != null) {
      final l = arr.length;
      for (var i = 0; i < l; ++i) {
        if (!proc(arr[i], i)) {
          break;
        }
      }
    }
  }

  static void Clear<T>(List<T> arr, void proc(T e)) {
    arr.forEach(proc);
    arr.clear();
  }

  static T QueryObject<T>(List<T> arr, bool filter(T e, int idx)) {
    if (arr != null) {
      for (var i = 0, l = arr.length; i < l; ++i) {
        var e = arr[i];
        if (filter(e, i)) {
          return e;
        }
      }
    }
    return null;
  }

  static List<T> QueryObjects<T>(List<T> arr, bool filter(T e, int idx)) {
    List<T> r = [];
    Foreach(arr, (e, idx) {
      if (filter(e, idx)) {
        r.add(e);
      }
      return true;
    });
    return r;
  }

  /** 使用比较函数来判断是否包含元素 */
  static bool Contains<L, R>(List<L> arr, R o, [bool eqfun(L l, R) = null]) {
    if (arr == null || arr.length == 0) {
      return false;
    }

    if (arr[0].runtimeType == o.runtimeType && IsPod(o)) {
      return arr.indexOf(o as L) != -1;
    }

    return null !=
        QueryObject(arr, (e, idx) {
          return ObjectT.IsEqual(e, o);
        });
  }

  /** 删除一个对象 */
  static bool RemoveObject<T>(List<T> arr, T obj) {
    if (obj == null || arr == null) {
      return false;
    }
    int idx = arr.indexOf(obj);
    if (idx == -1) {
      return false;
    }
    arr.removeAt(idx);
    return true;
  }

  /** 移除位于另一个 array 中的所有元素 */
  static void RemoveObjectsInArray<T>(List<T> arr, List<T> r) {
    arr.removeWhere((e) => Contains(r, e));
  }
}
