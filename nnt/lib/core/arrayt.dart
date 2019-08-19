part of nnt.core;

class ArrayT {
  static void Foreach<T>(List<T> arr, void proc(T e, int idx)) {
    final l = arr.length;
    for (var i = 0; i < l; ++i) {
      proc(arr[i], i);
    }
  }

  static void Clear<T>(List<T> arr, void proc(T e)) {
    arr.forEach(proc);
    arr.clear();
  }
}
