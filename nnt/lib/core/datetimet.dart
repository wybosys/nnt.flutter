part of nnt.core;

class DateTimeT {
  static int Now() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}

Timer Delay(double seconds, Function proc) {
  return Timer.periodic(Duration(milliseconds: seconds * 1000 as int), proc);
}
