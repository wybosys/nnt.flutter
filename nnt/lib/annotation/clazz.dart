part of nnt.annotation;

// 注册类
class clazz {
  const clazz();
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
