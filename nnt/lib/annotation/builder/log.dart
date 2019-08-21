part of nnt.annotation.builder;

class Log {
  static void metadata(List<ElementAnnotation> md, [Map tree = null]) {
    var p = false;
    if (tree == null) {
      tree = new Map();
      p = true;
    }

    Map cur = AvaMap(tree, 'root', Map());
    md.forEach((e) {
      annotation(e, AvaMap(cur, e.element.name, Map()));
    });

    if (p) print(tree);
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

    element(ele.element, AvaMap(tree, 'element', Map()));

    if (p) print(tree);
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
    tree['kind'] = ele.kind.toString();
    tree['name'] = ele.name;

    metadata(ele.metadata, AvaMap(tree, "metadata", Map()));

    if (p) print(tree);
  }
}
