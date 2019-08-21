part of nnt.annotation.builder;

class Log {
  static void log(dynamic obj) {
    var str = toJson(obj);
    print(str);
  }

  static void metadata(List<ElementAnnotation> md, [List tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new List();
      p = true;
    }

    md.forEach((e) {
      var m = Map();
      annotation(e, m);
      tree.add(m);
    });

    if (p) log(tree);
  }

  static void annotation(ElementAnnotation ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.isAlwaysThrows) tree['isAlwaysThrows'] = true;
    if (ele.isDeprecated) tree['isDeprecated'] = true;
    if (ele.isFactory) tree['isFactory'] = true;
    if (ele.isImmutable) tree['isImmutable'] = true;
    if (ele.isMustCallSuper) tree['isMustCallSuper'] = true;
    if (ele.isOptionalTypeArgs) tree['isOptionalTypeArgs'] = true;
    if (ele.isOverride) tree['isOverride'] = true;
    if (ele.isProtected) tree['isProtected'] = true;
    if (ele.isProxy) tree['isProxy'] = true;
    if (ele.isRequired) tree['isRequired'] = true;
    if (ele.isSealed) tree['isSealed'] = true;

    if (ele.element != null)
      element(ele.element, AvaMap(tree, 'element', Map()));

    if (p) log(tree);
  }

  static void element(Element ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.displayName != null) tree['displayName'] = ele.displayName;
    if (ele.documentationComment != null)
      tree['documentationComment'] = ele.documentationComment;
    if (ele.hasAlwaysThrows) tree['hasAlwaysThrows'] = true;
    if (ele.hasDeprecated) tree['hasDeprecated'] = true;
    if (ele.hasFactory) tree['hasFactory'] = true;
    if (ele.hasMustCallSuper) tree['hasMustCallSuper'] = true;
    if (ele.hasOptionalTypeArgs) tree['hasOptionalTypeArgs'] = true;
    if (ele.hasOverride) tree['hasOverride'] = true;
    if (ele.hasProtected) tree['hasProtected'] = true;
    if (ele.hasRequired) tree['hasRequired'] = true;
    if (ele.hasSealed) tree['hasSealed'] = true;

    tree['id'] = ele.id;
    tree['name'] = ele.name;

    kind(ele.kind, AvaMap(tree, 'kind', Map()));

    if (ele.metadata.length != 0)
      metadata(ele.metadata, AvaMap(tree, "metadata", List()));

    if (ele.enclosingElement != null)
      element(ele.enclosingElement, AvaMap(tree, 'enclosingElement', Map()));

    if (p) log(tree);
  }

  static void kind(ElementKind ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    tree['name'] = ele.name;
    tree['ordinal'] = ele.ordinal;
    tree['displayName'] = ele.displayName;

    if (p) log(tree);
  }

  static void method(MethodElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    classmember(ele, tree);
    executable(ele, tree);

    if (p) log(tree);
  }

  static void classmember(ClassMemberElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.isStatic) tree['isStatic'] = true;
    element(ele, tree);

    if (p) log(tree);
  }

  static void executable(ExecutableElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.hasImplicitReturnType) tree['hasImplicitReturnType'] = true;
    if (ele.isAbstract) tree['isAbstract'] = true;
    if (ele.isAsynchronous) tree['isAsynchronous'] = true;
    if (ele.isExternal) tree['isExternal'] = true;
    if (ele.isGenerator) tree['isGenerator'] = true;
    if (ele.isOperator) tree['isOperator'] = true;
    if (ele.isStatic) tree['isStatic'] = true;
    if (ele.isSynchronous) tree['isSynchronous'] = true;

    functiontyped(ele, tree);
    element(ele, tree);

    if (p) log(tree);
  }

  static void functiontyped(FunctionTypedElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.returnType != null)
      type(ele.returnType, AvaMap(tree, 'returnType', Map()));
    if (ele.type != null) functontype(ele.type, AvaMap(tree, 'type', Map()));

    element(ele, tree);
    if (p) log(tree);
  }

  static void typeparameterized(TypeParameterizedElement ele,
      [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.isSimplyBounded) tree['isSimplyBounded'] = true;
    if (ele.typeParameters.length != 0)
      typeparameters(
          ele.typeParameters, AvaMap(tree, 'typeParameters', List()));

    element(ele, tree);
    if (p) log(tree);
  }

  static void typeparameters(List<TypeParameterElement> eles,
      [List tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new List();
      p = true;
    }

    eles.forEach((v) {
      var m = Map();
      typeparameter(v, m);
      tree.add(m);
    });

    if (p) log(tree);
  }

  static void parameter(ParameterElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    tree['defaultValueCode'] = ele.defaultValueCode;
    if (ele.isCovariant) tree['isCovariant'] = true;
    if (ele.isInitializingFormal) tree['isInitializingFormal'] = true;
    if (ele.isNamed) tree['isNamed'] = true;
    if (ele.isNotOptional) tree['isNotOptional'] = true;
    if (ele.isOptional) tree['isOptional'] = true;
    if (ele.isOptionalNamed) tree['isOptionalNamed'] = true;
    if (ele.isOptionalPositional) tree['isOptionalPositional'] = true;
    if (ele.isPositional) tree['isPositional'] = true;
    if (ele.isRequiredNamed) tree['isRequiredNamed'] = true;
    if (ele.isRequiredPositional) tree['isRequiredPositional'] = true;

    if (ele.parameters.length != 0)
      parameters(ele.parameters, AvaMap(tree, 'parameters', List()));
    if (ele.typeParameters.length != 0)
      typeparameters(
          ele.typeParameters, AvaMap(tree, 'typeParameters', List()));

    local(ele, tree);
    variable(ele, tree);
    element(ele, tree);

    if (p) log(tree);
  }

  static void parameters(List<ParameterElement> eles, [List tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new List();
      p = true;
    }

    eles.forEach((v) {
      var m = Map();
      parameter(v, m);
      tree.add(m);
    });

    if (p) log(tree);
  }

  static void local(LocalElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    element(ele, tree);
    if (p) log(tree);
  }

  static void variable(VariableElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.hasImplicitType) tree['hasImplicitType'] = true;
    if (ele.initializer != null)
      function(ele.initializer, AvaMap(tree, 'initializer', Map()));
    if (ele.isConst) tree['isConst'] = true;
    if (ele.isFinal) tree['isFinal'] = true;
    if (ele.isStatic) tree['isStatic'] = true;

    if (ele.type != null) type(ele.type, AvaMap(tree, 'type', Map()));
    if (ele.constantValue != null)
      object(ele.constantValue, AvaMap(tree, 'constantValue', Map()));

    element(ele, tree);
    if (p) log(tree);
  }

  static void function(FunctionElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.isEntryPoint) tree['isEntryPoint'] = true;

    executable(ele, tree);
    local(ele, tree);

    if (p) log(tree);
  }

  static void object(DartObject ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.hasKnownValue) tree['hasKnownValue'] = true;
    if (ele.isNull) tree['isNull'] = true;

    if (ele.type != null)
      parameterizedtype(ele.type, AvaMap(tree, 'type', Map()));

    if (p) log(tree);
  }

  static void types(List<DartType> eles, [List tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new List();
      p = true;
    }

    eles.forEach((e) {
      var m = Map();
      type(e, m);
      tree.add(m);
    });

    if (p) log(tree);
  }

  static void maptypes(Map<String, DartType> eles, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    eles.forEach((k, e) {
      var m = Map();
      type(e, m);
      tree[k] = m;
    });

    if (p) log(tree);
  }

  static void type(DartType ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    tree['displayName'] = ele.displayName;
    tree['name'] = ele.name;

    if (ele.isDartAsyncFuture) tree['isDartAsyncFuture'] = true;
    if (ele.isDartAsyncFutureOr) tree['isDartAsyncFutureOr'] = true;
    if (ele.isDartCoreBool) tree['isDartCoreBool'] = true;
    if (ele.isDartCoreDouble) tree['isDartCoreDouble'] = true;
    if (ele.isDartCoreFunction) tree['isDartCoreFunction'] = true;
    if (ele.isDartCoreInt) tree['isDartCoreInt'] = true;
    if (ele.isDartCoreList) tree['isDartCoreList'] = true;
    if (ele.isDartCoreMap) tree['isDartCoreMap'] = true;
    if (ele.isDartCoreNull) tree['isDartCoreNull'] = true;
    if (ele.isDartCoreNum) tree['isDartCoreNum'] = true;
    if (ele.isDartCoreObject) tree['isDartCoreObject'] = true;
    if (ele.isDartCoreSet) tree['isDartCoreSet'] = true;
    if (ele.isDartCoreString) tree['isDartCoreString'] = true;
    if (ele.isDartCoreSymbol) tree['isDartCoreSymbol'] = true;
    if (ele.isDynamic) tree['isDynamic'] = true;
    if (ele.isObject) tree['isObject'] = true;
    if (ele.isVoid) tree['isVoid'] = true;

    if (ele.element != null)
      element(ele.element, AvaMap(tree, 'element', Map()));

    if (p) log(tree);
  }

  static void functontype(FunctionType ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.namedParameterTypes.length != 0)
      maptypes(
          ele.namedParameterTypes, AvaMap(tree, 'namedParameterTypes', Map()));

    if (ele.normalParameterNames.length != 0)
      tree['normalParameterNames'] = ele.normalParameterNames;

    if (ele.normalParameterTypes.length != 0)
      types(ele.normalParameterTypes,
          AvaMap(tree, 'normalParameterTypes', List()));

    if (ele.optionalParameterNames.length != 0)
      tree['optionalParamterNames'] = ele.optionalParameterNames;

    if (ele.optionalParameterTypes.length != 0)
      types(ele.optionalParameterTypes,
          AvaMap(tree, 'optionalParameterTypes', List()));

    if (ele.parameters.length != 0)
      parameters(ele.parameters, AvaMap(tree, 'parameters', List()));

    if (ele.returnType != null)
      type(ele.returnType, AvaMap(tree, 'returnType', Map()));

    if (ele.typeFormals.length != 0)
      typeparameters(ele.typeFormals, AvaMap(tree, 'typeFormals', List()));

    parameterizedtype(ele, tree);

    if (p) log(tree);
  }

  static void parameterizedtype(ParameterizedType ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.typeArguments.length != 0)
      types(ele.typeArguments, AvaMap(tree, 'typeArguments', List()));

    if (ele.typeParameters.length != 0)
      typeparameters(
          ele.typeParameters, AvaMap(tree, 'typeParameters', List()));

    type(ele, tree);

    if (p) log(tree);
  }

  static void typeparameter(TypeParameterElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.bound != null) type(ele.bound, AvaMap(tree, 'bound', Map()));
    typedefining(ele, tree);

    if (p) log(tree);
  }

  static void typedefining(TypeDefiningElement ele, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    if (ele.type != null) type(ele.type, AvaMap(tree, 'type', Map()));

    element(ele, tree);
    if (p) log(tree);
  }
}
