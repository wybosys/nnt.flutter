part of nnt.annotation.builder;

const TPL_CLAZZ = '''
class __clazz_{{clazz}} extends Clazz {
__clazz_{{clazz}}() {
name = '{{clazz}}';
library = '{{lib}}';
proto = {{clazz}};
instance = ()=>{{clazz}}();
}
}
''';

const TPL_REGISTER = '''
void _RegisterClazzes() {
{{#clazzes}}RegisterClazz(new {{.}}());{{/clazzes}}
}
''';

Builder clazzes(BuilderOptions options) {
  return SharedPartBuilder([Clazzes(), Registers()], 'clazz');
}

// 保存找到的需要注册到类长的类全名
var __clazzes = new Set();

class Clazzes extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var t = new Template(TPL_CLAZZ);
    __clazzes.add("${element.library.name}.${element.name}");
    return t.renderString({'clazz': element.name, 'lib': element.library.name});
  }
}

class Registers extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    // 遍历lib中所有的类，注册 __factory_ 作为类名的类
    var t = new Template(TPL_REGISTER);
    return t.renderString(
        {'clazzes': clazzes(library).map((ele) => "__clazz_${ele.name}")});
  }

  Iterable<ClassElement> clazzes(LibraryReader reader) {
    var lib = reader.element.name;
    return reader.allElements.whereType<ClassElement>().where((ele) {
      final full = "$lib.${ele.name}";
      return __clazzes.contains(full);
    });
  }
}
