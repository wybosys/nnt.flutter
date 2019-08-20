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
  return SharedPartBuilder(
      [Clazzes(), Functions(), Variables(), Registers()], 'clazz');
}

// 保存找到的需要注册到类长的类全名
var __clazzes = new Set();

class ClazzChildVisitor<R> extends ElementVisitor<R> {
  R visitClassElement(ClassElement element) {}

  R visitCompilationUnitElement(CompilationUnitElement element) {}

  R visitConstructorElement(ConstructorElement element) {}

  R visitExportElement(ExportElement element) {}

  R visitExtensionElement(ExtensionElement element) {}

  R visitFieldElement(FieldElement element) {
    print(element.name);
  }

  R visitFieldFormalParameterElement(FieldFormalParameterElement element) {}

  R visitFunctionElement(FunctionElement element) {
    print(element.name);
  }

  R visitFunctionTypeAliasElement(FunctionTypeAliasElement element) {}

  R visitGenericFunctionTypeElement(GenericFunctionTypeElement element) {}

  R visitImportElement(ImportElement element) {}

  R visitLabelElement(LabelElement element) {}

  R visitLibraryElement(LibraryElement element) {}

  R visitLocalVariableElement(LocalVariableElement element) {}

  R visitMethodElement(MethodElement element) {}

  R visitMultiplyDefinedElement(MultiplyDefinedElement element) {}

  R visitParameterElement(ParameterElement element) {}

  R visitPrefixElement(PrefixElement element) {}

  R visitPropertyAccessorElement(PropertyAccessorElement element) {}

  R visitTopLevelVariableElement(TopLevelVariableElement element) {}

  R visitTypeParameterElement(TypeParameterElement element) {}
}

class Clazzes extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    element.visitChildren(new ClazzChildVisitor());
    var t = new Template(TPL_CLAZZ);
    __clazzes.add("${element.library.name}.${element.name}");
    return t.renderString({'clazz': element.name, 'lib': element.library.name});
  }
}

class Functions extends GeneratorForAnnotation<func> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print('xxxxxxxxxxxxxxxxxxx' + element.name);
    return '';
  }
}

class Variables extends GeneratorForAnnotation<varc> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print('yyyyyyyy' + element.name);
    return '';
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
