part of nnt.annotation.builder;

const TPL_CLAZZ = '''
class __clazz_{{clazz}} extends Clazz {
__clazz_{{clazz}}() {
name = '{{clazz}}';
library = '{{lib}}';
dynamic _p = proto = {{clazz}};
instance = ()=>{{clazz}}();
{{#funcs}}
funcs['{{name}}'] = Func('{{name}}', _p.{{name}});
{{/funcs}}
{{#vars}}
vars['{{name}}'] = Varc('{{name}}', {{type}}, {{readonly}});
{{/vars}}
}
}
''';

const TPL_REGISTER = '''
void _RegisterClazzes() {
{{#clazzes}}RegisterClazz(new __clazz_{{name}}());{{/clazzes}}
}
''';

Builder clazzes(BuilderOptions options) {
  return SharedPartBuilder([Clazzes(), Registers()], 'clazz');
}

// 保存找到的需要注册到类厂的类
var __clazzes = new Map<String, Clazz>();

class DevVarc extends Varc {
  // 类型名称
  String typeName;
}

class _ClazzChildVisitor extends EmptyVisitor<void> {
  _ClazzChildVisitor(this._clazz);

  // 用来处理找到的类信息
  Clazz _clazz;

  void visitFieldElement(FieldElement element) {
    // 判断是否是显式标注，没有标注的函数认为是私有函数，跳过处理
    if (element.metadata.length == 0) return;
    var first = element.metadata[0].element.enclosingElement;
    // 通过varc标注需要暴露的变量
    if (first.name != 'varc') return;
    // 读取变量信息
    var vc = new DevVarc();
    vc.name = element.name;
    vc.typeName = element.type.name;
    vc.readonly = element.getter == null;
    _clazz.vars[vc.name] = vc;
  }

  void visitMethodElement(MethodElement element) {
    // 判断是否是显式标注，没有标注的函数认为是私有函数，跳过处理
    if (element.metadata.length == 0) return;
    var first = element.metadata[0].element.enclosingElement;
    // 通过func标注需要暴露的函数
    if (first.name != 'func') return;
    // 读取函数信息
    var fn = new Func();
    fn.name = element.name;
    _clazz.funcs[fn.name] = fn;
  }
}

class Clazzes extends GeneratorForAnnotation<clazz> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var clz = new Clazz<Func, DevVarc>();
    clz.name = element.name;
    clz.library = element.library.name;
    __clazzes[clz.fullname] = clz;

    var visitor = new _ClazzChildVisitor(clz);
    element.visitChildren(visitor);

    var t = new Template(TPL_CLAZZ);
    return t.renderString(_paramlizeOne(clz));
  }

  Map _paramlizeOne(Clazz<Func, DevVarc> clz) {
    var funcs = [];
    clz.funcs.forEach((k, fn) {
      funcs.add({'name': fn.name});
    });
    var vars = [];
    clz.vars.forEach((k, v) {
      vars.add({'name': v.name, 'type': v.typeName, 'readonly': v.readonly});
    });
    return {
      'clazz': clz.name,
      'lib': clz.library,
      'funcs': funcs,
      'vars': vars
    };
  }
}

class Registers extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    // 遍历lib中所有的类，注册 __factory_ 作为类名的类
    var t = new Template(TPL_REGISTER);
    // 构造用来输出到模板的参数
    return t.renderString(
        {'clazzes': clazzes(library).map((ele) => _paramlizeOne(ele))});
  }

  Map _paramlizeOne(Clazz clz) {
    return {'name': clz.name};
  }

  List<Clazz> clazzes(LibraryReader reader) {
    var ret = List<Clazz>();
    var lib = reader.element.name;
    for (var ele in reader.allElements) {
      final full = "$lib.${ele.name}";
      if (__clazzes.containsKey(full)) {
        ret.add(__clazzes[full]);
      }
    }
    return ret;
  }
}
