part of nnt.annotation;

// 注册类
class clazz {
  const clazz();
}

Builder clazzBuilder(BuilderOptions options) {
  return SharedPartBuilder([ClazzGenerator()], 'clazz_generator');
}

class ClazzGenerator extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {}
}
