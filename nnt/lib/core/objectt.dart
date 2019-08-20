part of nnt.core;

class ObjectT {
  /** 比较两个实例是否相等
      @brief 优先使用比较函数的结果
   */
  static bool IsEqual<L, R>(L l, R r, [bool eqfun(L l, R r) = null]) {
    if (l == null || r == null) {
      return false;
    }
    if (eqfun != null) {
      return eqfun(l, r);
    }
    return l as dynamic == r as dynamic;
  }
}
