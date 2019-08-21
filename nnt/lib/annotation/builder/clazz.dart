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

class ClazzChildVisitor<R> extends ElementVisitor<R> {
  R visitClassElement(ClassElement element) {
    print("class: ${element.name}");
  }

  R visitCompilationUnitElement(CompilationUnitElement element) {
    print("compilation-unit: ${element.name}");
  }

  R visitConstructorElement(ConstructorElement element) {
    print("constructor: ${element.name}");
  }

  R visitExportElement(ExportElement element) {
    print("export: ${element.name}");
  }

  R visitExtensionElement(ExtensionElement element) {
    print("extension: ${element.name}");
  }

  R visitFieldElement(FieldElement element) {
    print("field: ${element.name}");
  }

  R visitFieldFormalParameterElement(FieldFormalParameterElement element) {
    print("field-formal-parameter: ${element.name}");
  }

  R visitFunctionElement(FunctionElement element) {
    print("function: ${element.name}");
  }

  R visitFunctionTypeAliasElement(FunctionTypeAliasElement element) {
    print("function-type-alias: ${element.name}");
  }

  R visitGenericFunctionTypeElement(GenericFunctionTypeElement element) {
    print("generic-function-type: ${element.name}");
  }

  R visitImportElement(ImportElement element) {
    print("import: ${element.name}");
  }

  R visitLabelElement(LabelElement element) {
    print("label: ${element.name}");
  }

  R visitLibraryElement(LibraryElement element) {
    print("library: ${element.name}");
  }

  R visitLocalVariableElement(LocalVariableElement element) {
    print("local-variable: ${element.name}");
  }

  R visitMethodElement(MethodElement element) {
    print("method: ${element.name}");
    if (element.type == func) {
      print('xxxxxxxxxxxxxxxxx');
    } else {
      print('yyyyyyyyyyyyyyy');
    }
  }

  R visitMultiplyDefinedElement(MultiplyDefinedElement element) {
    print("multiply-defined: ${element.name}");
  }

  R visitParameterElement(ParameterElement element) {
    print("parameter: ${element.name}");
  }

  R visitPrefixElement(PrefixElement element) {
    print("prefix: ${element.name}");
  }

  R visitPropertyAccessorElement(PropertyAccessorElement element) {
    print("property-accessor: ${element.name}");
  }

  R visitTopLevelVariableElement(TopLevelVariableElement element) {
    print("top-level-variable: ${element.name}");
  }

  R visitTypeParameterElement(TypeParameterElement element) {
    print("type-parameter: ${element.name}");
  }
}

class Clazzes extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var visitor = new ClazzChildVisitor();
    element.visitChildren(visitor);
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
