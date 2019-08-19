part of nnt.annotation.builder;

const TPL_CLAZZ = '''
class __factory_{{clazz}} extends Clazz {
__factory_{{clazz}}() {
name = '{{clazz}}';
library = '{{lib}}';
proto = {{clazz}};
instance = ()=>{{clazz}}();
}
}
''';

const TPL_REGISTER = '''
void _RegisterFactoryClasses() {

}
''';

Builder clazzToFactory(BuilderOptions options) {
  return SharedPartBuilder([ClazzToFactory(), FactoryRegister()], 'clazz');
}

class ClazzToFactory extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var t = new Template(TPL_CLAZZ);
    return t.renderString({'clazz': element.name, 'lib': element.library.name});
  }
}

class FactoryRegister extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    // 遍历lib中所有的类，注册 __factory_ 作为类名的类
    var t = new Template(TPL_REGISTER);
    print(library.element.name);
    return t.renderString({});
  }
}
