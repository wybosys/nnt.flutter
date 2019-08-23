part of nnt.test;

@clazz()
class Test {
  @func()
  String run([String arg]) {
    var t = msg + (arg != null ? arg : '');
    print(t);
    return t;
  }

  @func()
  Future<int> foo(String arg) async {
    var t = msg + arg;
    print(t);
    return 0;
  }

  @func()
  Future<void> hello() {
    print(msg);
  }

  @varc()
  String msg = 'hello, flutter!';
}
