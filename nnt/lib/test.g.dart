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
    funcs['run'] = Func('run', (obj) => obj.run());
    vars['msg'] = Varc('msg', String, false);
  }
}

// **************************************************************************
// Generator: Registers
// **************************************************************************

void _RegisterClazzes() {
  RegisterClazz(new __clazz_Test());
}
