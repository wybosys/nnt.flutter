part of nnt.gui;

const TPL_CLAZZ = '''
var {{clazz}} = (function (_super) {
    __extends({{clazz}}, _super);
    function {{clazz}}() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    {{#funcs}}
    {{clazz}}.prototype.{{name}} = function () {
        nnt.flutter.jsb.toApp(new nnt.flutter.Message({{name}}));
    };
    {{/funcs}}
    return {{clazz}};
}(nnt.flutter.JsObject));
''';
