part of nnt.core;

class AsyncT {
  static Future<List<dynamic>> AllThen(List<Function> fns) {
    var done = Completer();
    List<dynamic> result = [];
    if (fns.length == 0) {
      done.complete(result);
      return done.future;
    }
    ArrayT.Foreach(fns, (e, idx) {
      e().then((code) {
        result[idx] = code;
        if (result.length == fns.length) {
          done.complete(result);
        }
      });
      return true;
    });
    return done.future;
  }
}
