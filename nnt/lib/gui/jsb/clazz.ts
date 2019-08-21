// 映射dart类到js中的模板
export class Test extends nnt.flutter.JsObject {
    hello() {
        return nnt.flutter.jsb.toApp(new nnt.flutter.Message(this.objectId, 'hello'));
    }
}

var test = new Test();
test.objectId = 123;