part of nnt.annotation.builder;

const TPL_CLAZZ = '''
class _C{{clazz}} extends Clazz {
_C{{clazz}}() {
name = '{{clazz}}';
library = '{{lib}}';
proto = {{clazz}};
instance = ()=>{{clazz}}();
}
}
''';

Builder clazzBuilder(BuilderOptions options) {
  return SharedPartBuilder([ClazzGenerator()], 'clazz');
}

class ClazzGenerator extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var t = new Template(TPL_CLAZZ);
    return t.renderString({'clazz': element.name, 'lib': element.library.name});
  }
}
