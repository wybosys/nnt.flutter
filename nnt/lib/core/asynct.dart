part of nnt.core;

class AsyncT {
  static Future<List<dynamic>> AllThen(List<Function> fns) {
    var done = Completer();
    List<dynamic> res = [];
    if (fns.length == 0) {
      done.complete(res);
      return done.future;
    }
    ArrayT.Foreach(fns, (e, idx) {
      e().then((res) {
        res[idx] = res;
        if (res.length == fns.length) {
          done.complete(res);
        }
      });
      return true;
    });
    return done.future;
  }
}
