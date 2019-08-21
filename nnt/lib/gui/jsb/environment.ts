namespace nnt.flutter {

    type int = number;
    type IndexedObject = {
        [key: string]: any
    };

    // app段匹配的随机数据
    const SCHEME = 'nf20w';

    // jsobj的函数形式
    type FnJsObject = (params: IndexedObject) => void;

    export class JsObject {

        // 对象id
        objectId: int;
    }

    export class Message {

        constructor(action?: string, params?: IndexedObject) {
            this.action = action;
            this.params = params;
        }

        // 对象id
        objectId: int;

        // 动作
        action: string;

        // 数据
        params: IndexedObject;

        // 序列化和反序列化
        serialize(): string {
            let raw = JSON.stringify({
                o: this.objectId,
                a: this.action,
                p: this.params ? this.params : {}
            });
            raw = encodeURI(raw);
            return `${SCHEME}://${raw}`;
        }

        unserialize(raw: string) {
            raw = raw.substr(SCHEME.length + 3);
            raw = decodeURI(raw);
            var obj = JSON.parse(raw);
            this.objectId = obj.o;
            this.action = obj.a;
            this.params = obj.p;
        }
    }

    // 用来保存所有从app添加到js的对象
    let _objects: IndexedObject = {};

    class _JsBridge {

        // 添加对象到js中
        addJsObj(obj: JsObject) {
            if (!obj.objectId) {
                alert('添加没有从JsObject继承的对象');
                return;
            }

            _objects[obj.objectId] = obj;
        }

        // 接受从app中传来的消息
        fromApp(raw: string) {
            if (raw.indexOf(SCHEME) != 0) {
                alert(`收到了不支持的数据 ${raw}`);
                return;
            }

            let msg = new Message();
            msg.unserialize(raw);

            // 查找池子里的对象
            let obj = _objects[msg.objectId];
            if (!obj) {
                alert(`找不到对象 ${msg.objectId}`);
                return;
            }

            if (!obj[msg.action]) {
                alert(`找不到动作 ${msg.action}`);
                return;
            }

            // 执行函数
            obj[msg.action](msg.params);
        }

        // 给app发送消息
        toApp(msg: Message) {
            let raw = msg.serialize();

            // app通过拦截href来实现
            location.href = raw;
        }
    }

    export const jsb = new _JsBridge();

    // 为了使ts生成对应的工具头
    export class _JsObject extends JsObject { }
}