// 映射dart类到js中的模板
export class Test extends nnt.flutter.JsObject {
    hello() {
        nnt.flutter.jsb.toApp(new nnt.flutter.Message('hello'));
    }
}

var test = new Test();
test.objectId = 123;