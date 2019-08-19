part of nnt.annotation.builder;

Builder clazzBuilder(BuilderOptions options) {
  return SharedPartBuilder([ClazzGenerator()], 'clazz');
}

class ClazzGenerator extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return "var _${element.name} = new RegisterClazzByGenerator('${element.name}', '${element.library.name}');";
  }
}
