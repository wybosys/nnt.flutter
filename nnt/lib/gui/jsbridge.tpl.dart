part of nnt.gui;

const TPL_CLAZZ = '''
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var {{clazz}} = (function (_super) {
    __extends({{clazz}}, _super);
    function {{clazz}}() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    {{#funcs}}
    {{clazz}}.prototype.{{name}} = function ({{args}}) {
        return nnt.flutter.jsb.toApp(new nnt.flutter.Message(this.objectId, '{{name}}', {{&params}}));
    };
    {{/funcs}}
    return {{clazz}};
}(nnt.flutter.JsObject));
''';

const TPL_VARIABLE = '''
var {{name}} = new {{clazz}}();
{{name}}.objectId = {{objid}};
''';

const TPL_TMP_VARIABLE = '''
nnt.flutter.tmp.{{name}} = new {{clazz}}();
nnt.flutter.tmp.{{name}}.objectId = {{objid}};
''';
