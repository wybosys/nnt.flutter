// GENERATED CODE - DO NOT MODIFY BY HAND

part of nnt.test;

// **************************************************************************
// Generator: Clazzes
// **************************************************************************

class __clazz_Test extends Clazz {
  __clazz_Test() {
    name = 'Test';
    library = 'nnt.test';
    proto = Test;
    instance = () => Test();
    funcs['run'] = Func(
        'run',
        (Test obj, [String arg]) => obj.run(arg),
        [Varc('arg', String, false, true, false)],
        Varc('', String, false, false, false));
    funcs['foo'] = Func(
        'foo',
        (
          Test obj,
          String arg,
        ) =>
            obj.foo(arg),
        [Varc('arg', String, false, false, false)],
        Varc('', int, false, false, true));
    funcs['hello'] = Func('hello', (Test obj) => obj.hello(), [],
        Varc('', Void, false, false, true));
    vars['msg'] = Varc('msg', String, false);
  }
}

// **************************************************************************
// Generator: Registers
// **************************************************************************

void _RegisterClazzes() {
  RegisterClazz(new __clazz_Test());
}
