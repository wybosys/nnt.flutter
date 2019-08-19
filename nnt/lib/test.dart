library nnt.test;

import 'package:nnt/annotation.dart';

part 'test/foo.dart';
part 'test/test.dart';
part 'test.g.dart';

void libTestInit() {
  var _Foo = new RegisterClazzByGenerator('Foo', 'nnt.test');
}
