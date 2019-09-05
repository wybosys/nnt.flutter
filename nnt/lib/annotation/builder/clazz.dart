part of nnt.annotation.builder;

const TPL_CLAZZ = '''
class __clazz_{{clazz}} extends Clazz {
__clazz_{{clazz}}() {
name = '{{clazz}}';
library = '{{lib}}';
proto = {{clazz}};
instance = ()=>{{clazz}}();
{{#funcs}}
  funcs['{{name}}'] = Func('{{name}}', 
    ({{clazz}} obj {{&decl}}) => obj.{{name}}({{&inps}}), 
    {{&arg}}, {{&ret}});
{{/funcs}}
{{#vars}}
vars['{{name}}'] = Varc('{{name}}', {{&type}}, {{readonly}});
{{/vars}}
}
}
''';

const TPL_VARIABLE = '''
Varc('{{name}}', {{&type}}, {{readonly}}, {{optional}}, {{async}})
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

    if (!element.returnType.isVoid) {
      var v = DevVarc();
      var rt = element.returnType;
      v.typeName = rt.name;
      v.async = rt.isDartAsyncFuture;
      if (v.async) {
        // Future<xxx>
        v.typeName = rt.displayName.substring(7, rt.displayName.length - 1);
        if (v.typeName == 'void') v.typeName = 'Void';
      }
      fn.ret = v;
    }

    if (element.parameters != null && element.parameters.length > 0) {
      List<DevVarc> args = [];
      element.parameters.forEach((e) {
        var v = DevVarc();
        v.name = e.name;
        v.optional = e.isOptional;
        v.typeName = e.type.name;
        v.async = e.type.isDartAsyncFuture;
        if (v.async) {
          // Future<xxx>
          v.typeName =
              e.type.displayName.substring(7, e.type.displayName.length - 1);
          if (v.typeName == 'void') v.typeName = 'Void';
        }
        args.add(v);
      });
      fn.args = args;
    }

    _clazz.funcs[fn.name] = fn;
  }
}

class Clazzes extends GeneratorForAnnotation<clazz> {
  var tpl_clazz = new Template(TPL_CLAZZ);
  var tpl_variable = new Template(TPL_VARIABLE);

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var clz = new Clazz();
    clz.name = element.name;
    clz.library = element.library.name;
    __clazzes[clz.fullname] = clz;

    var visitor = new _ClazzChildVisitor(clz);
    //element.visitChildren(LogVisitor());
    element.visitChildren(visitor);

    return tpl_clazz.renderString(_paramlizeOne(clz));
  }

  Map _paramlizeOne(Clazz clz) {
    var funcs = [];
    clz.funcs.forEach((k, fn) {
      // 入参表
      String arg = '[]';
      String decl = '';
      List<String> inps = [];
      if (fn.args != null) {
        List<String> args = [];
        List<String> ris = [];
        List<String> ois = [];
        fn.args.forEach((e) {
          DevVarc de = e;
          var t = {
            'name': de.name,
            'type': de.typeName,
            'readonly': false,
            'optional': de.optional,
            'async': de.async
          };
          args.add(tpl_variable.renderString(t));

          if (de.optional) {
            ois.add("${de.typeName} ${de.name}");
          } else {
            ris.add("${de.typeName} ${de.name}");
          }

          inps.add(de.name);
        });
        arg = "[${args.join(',')}]";

        // 合并输入参数
        decl = ',';
        if (ris.length > 0) {
          decl += ris.join(',') + ',';
        }
        if (ois.length > 0) {
          decl += "[${ois.join(',')}]";
        }
      }

      // 返回值
      String ret = 'null';
      if (fn.ret != null) {
        DevVarc de = fn.ret;
        var t = {
          'name': '',
          'type': de.typeName,
          'readonly': false,
          'optional': false,
          'async': de.async
        };
        ret = tpl_variable.renderString(t);
      }

      var t = {
        'name': fn.name,
        'arg': arg,
        'ret': ret,
        'decl': decl,
        'inps': inps.join(',')
      };
      funcs.add(t);
    });
    var vars = [];
    clz.vars.forEach((k, v) {
      DevVarc de = v;
      vars.add({'name': de.name, 'type': de.typeName, 'readonly': de.readonly});
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
