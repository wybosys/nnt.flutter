part of nnt.gui;

const TPL_CLAZZ = '''
var {{clazz}} = (function (_super) {
    __extends({{clazz}}, _super);
    function {{clazz}}() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    {{#funcs}}
    {{clazz}}.prototype.{{name}} = function ({{args}}) {
        nnt.flutter.jsb.toApp(new nnt.flutter.Message(this.objectId, '{{name}}', {{&params}}));
    };
    {{/funcs}}
    return {{clazz}};
}(nnt.flutter.JsObject));
''';

const TPL_VARIABLE = '''
var {{name}} = new {{clazz}}();
{{name}}.objectId = {{objid}};
''';
