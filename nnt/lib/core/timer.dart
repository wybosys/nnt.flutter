part of nnt.core;

Future<void> Sleep(double seconds) {
  var f = seconds.toInt();
  var m = ((seconds - f) * 1000).toInt();
  var dur = Duration(seconds: f, milliseconds: m);
  var done = Completer();
  new Timer(dur, () {
    done.complete();
  });
  return done.future;
}
