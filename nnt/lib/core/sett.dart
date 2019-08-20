part of nnt.core;

class SetT {
  static void Clear<T>(Set<T> arr, void proc(T e)) {
    arr.forEach(proc);
    arr.clear();
  }
}
