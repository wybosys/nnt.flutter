part of nnt.annotation.builder;

class EmptyVisitor<R> extends ElementVisitor<R> {
  R visitClassElement(ClassElement element) {
    //print("class: ${element.name}");
  }

  R visitCompilationUnitElement(CompilationUnitElement element) {
    //print("compilation-unit: ${element.name}");
  }

  R visitConstructorElement(ConstructorElement element) {
    //print("constructor: ${element.name}");
  }

  R visitExportElement(ExportElement element) {
    //print("export: ${element.name}");
  }

  R visitExtensionElement(ExtensionElement element) {
    //print("extension: ${element.name}");
  }

  R visitFieldElement(FieldElement element) {
    //print("field: ${element.name}");
  }

  R visitFieldFormalParameterElement(FieldFormalParameterElement element) {
    //print("field-formal-parameter: ${element.name}");
  }

  R visitFunctionElement(FunctionElement element) {
    //print("function: ${element.name}");
  }

  R visitFunctionTypeAliasElement(FunctionTypeAliasElement element) {
    //print("function-type-alias: ${element.name}");
  }

  R visitGenericFunctionTypeElement(GenericFunctionTypeElement element) {
    //print("generic-function-type: ${element.name}");
  }

  R visitImportElement(ImportElement element) {
    //print("import: ${element.name}");
  }

  R visitLabelElement(LabelElement element) {
    //print("label: ${element.name}");
  }

  R visitLibraryElement(LibraryElement element) {
    //print("library: ${element.name}");
  }

  R visitLocalVariableElement(LocalVariableElement element) {
    //print("local-variable: ${element.name}");
  }

  R visitMethodElement(MethodElement element) {
    //print("method: ${element.name}");
  }

  R visitMultiplyDefinedElement(MultiplyDefinedElement element) {
    //print("multiply-defined: ${element.name}");
  }

  R visitParameterElement(ParameterElement element) {
    //print("parameter: ${element.name}");
  }

  R visitPrefixElement(PrefixElement element) {
    //print("prefix: ${element.name}");
  }

  R visitPropertyAccessorElement(PropertyAccessorElement element) {
    //print("property-accessor: ${element.name}");
  }

  R visitTopLevelVariableElement(TopLevelVariableElement element) {
    //print("top-level-variable: ${element.name}");
  }

  R visitTypeParameterElement(TypeParameterElement element) {
    //print("type-parameter: ${element.name}");
  }
}

class LogVisitor<R> extends ElementVisitor<R> {
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
    Log.field(element);
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
    Log.method(element);
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
