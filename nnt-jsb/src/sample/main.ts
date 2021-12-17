// 映射dart类到js中的模板
export class Test extends nnt.flutter.JsObject {
    hello(abc: any) {
        return nnt.flutter.jsb.toApp(new nnt.flutter.Message(this.objectId, abc));
    }
}

var test = new Test();
test.objectId = 123;
test.hello("haha").then(res => {
    console.log(res);
}).catch(err => {
    console.error(err);
});
