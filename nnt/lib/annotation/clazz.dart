part of nnt.annotation;

class Clazzes {}

Builder ClazzBuilder<T>(BuilderOptions options) {
  return SharedPartBuilder([ClazzGenerator<T>()], 'clazz_generator');
}

class ClazzGenerator<T> extends GeneratorForAnnotation<T> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {}
}
