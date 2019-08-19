part of nnt.annotation;

// 注册类
class clazz {
  const clazz();
}

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

class RegisterClazzByGenerator {
  RegisterClazzByGenerator(String name, String library) {
    clazz.name = name;
    clazz.library = library;
    print("注册类 ${clazz.library}.${clazz.name}");
    RegisterClazz(clazz);
  }

  Clazz clazz = new Clazz();
}
