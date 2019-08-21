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

        constructor(objid: int, action: string, params?: IndexedObject) {
            this.objectId = objid;
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

            let msg = new Message(0, null);
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
            // console.log('msg: ' + raw);
            location.href = raw;
        }
    }

    export const jsb = new _JsBridge();

    // 兼容实现promise
    type PromiseInitT<T> = (resolve: (value?: T | PromiseLike<T>) => void, reject: (reason?: any) => void) => void;

    // Reentrant Promise 可以重入的Promise，解决标准Promise的resolve/reject只能调用一次的问题
    class Promise<T> {

        constructor(executor: PromiseInitT<T>) {
            this._executor = executor;

            // 延迟执行，业务会设置then等后处理
            setTimeout(() => {
                this._do();
            }, 0);
        }

        private _executor: PromiseInitT<T>;
        private _thens: Function[] = [];
        private _catchs: Function[] = [];

        then(func: Function): this {
            this._thens.push(func);
            return this;
        }

        catch(func: Function): this {
            this._catchs.push(func);
            return this;
        }

        private _do() {
            try {
                this._executor(obj => {
                    this._thens.forEach(e => {
                        e(obj);
                    });
                }, reason => {
                    if (this._catchs.length) {
                        this._catchs.forEach(e => {
                            try {
                                e(reason);
                            } catch (err) {
                                console.log(err);
                            }
                        });
                    } else {
                        console.log(reason);
                    }
                });
            } catch (err) {
                if (this._catchs.length) {
                    this._catchs.forEach(e => {
                        e(err);
                    });
                } else {
                    throw err;
                }
            }
        }
    }

    // 为了使ts生成对应的工具头
    export class _JsObject extends JsObject {
        async test() {
            return false;
        }
    }
}