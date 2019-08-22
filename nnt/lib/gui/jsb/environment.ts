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

    let _msgid = 0;

    export class Message {

        constructor(objid: int, action: string, params?: IndexedObject) {
            this.objectId = objid;
            this.action = action;
            this.params = params;
        }

        // 对象id
        objectId: int;

        // 消息的id
        id: int;

        // 动作
        action: string;

        // 数据
        params: IndexedObject;

        // 序列化和反序列化
        serialize(): string {
            let raw = JSON.stringify({
                o: this.objectId,
                i: this.id,
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
            this.id = obj.i;
            this.action = obj.a;
            this.params = obj.p;
        }
    }

    // 错误码
    export enum STATUS {
        UNKNOWN = -1000,
        EXCEPTION = -999, // 遇到了未处理的异常
        ROUTER_NOT_FOUND = -998, // 没有找到路由
        CONTEXT_LOST = -997, // 上下文丢失
        MODEL_ERROR = -996, // 恢复模型失败
        PARAMETER_NOT_MATCH = -995, // 参数不符合要求
        NEED_AUTH = -994, // 需要登陆
        TYPE_MISMATCH = -993, // 参数类型错误
        FILESYSTEM_FAILED = -992, // 文件系统失败
        FILE_NOT_FOUND = -991, // 文件不存在
        ARCHITECT_DISMATCH = -990, // 代码不符合标准架构
        SERVER_NOT_FOUND = -989, // 没有找到服务器
        LENGTH_OVERFLOW = -988, // 长度超过限制
        TARGET_NOT_FOUND = -987, // 目标对象没有找到
        PERMISSIO_FAILED = -986, // 没有权限
        WAIT_IMPLEMENTION = -985, // 等待实现
        ACTION_NOT_FOUND = -984, // 没有找到动作
        TARGET_EXISTS = -983, // 已经存在
        STATE_FAILED = -982, // 状态错误
        UPLOAD_FAILED = -981, // 上传失败
        MASK_WORD = -980, // 有敏感词
        SELF_ACTION = -979, // 针对自己进行操作
        PASS_FAILED = -978, // 验证码匹配失败
        OVERFLOW = -977, // 数据溢出
        AUTH_EXPIRED = -976, // 授权过期
        SIGNATURE_ERROR = -975, // 签名错误
        FORMAT_ERROR = -974,  // 返回的数据格式错误
        CONFIG_ERROR = -973, // 配置错误
        PRIVILEGE_ERROR = -972, // 权限错误
        LIMIT = -971, // 受到限制
        PAGED_OVERFLOW = -970, // 超出分页数据的处理能力
        NEED_ITEMS = -969, // 需要额外物品

        IM_CHECK_FAILED = -899, // IM检查输入的参数失败
        IM_NO_RELEATION = -898, // IM检查双方不存在关系

        SOCK_WRONG_PORTOCOL = -860, // SOCKET请求了错误的通讯协议
        SOCK_AUTH_TIMEOUT = -859, // 因为连接后长期没有登录，所以服务端主动断开了链接
        SOCK_SERVER_CLOSED = -858, // 服务器关闭

        THIRD_FAILED = -5, // 第三方出错
        MULTIDEVICE = -4, // 多端登陆
        HFDENY = -3, // 高频调用被拒绝（之前的访问还没有结束) high frequency deny
        TIMEOUT = -2, // 超时
        FAILED = -1, // 一般失败
        OK = 0, // 成功    
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
            // 分配新的id
            msg.id = ++_msgid;
            let raw = msg.serialize();

            // 监听消息
            let pm = new Promise((resolve, reject) => {
                this._waitings[msg.id] = { resolve, reject };
            });

            // app通过拦截href来实现
            // console.log('msg: ' + raw);
            location.href = raw;

            return pm;
        }

        // app发送结果
        result(raw: string) {
            let msg = new Message(0, null);
            msg.unserialize(raw);

            let s = this._waitings[msg.id];
            if (s) {
                delete this._waitings[msg.id];
                let p = msg.params;
                if (p.ok) {
                    s.resolve(p.ok);
                } else {
                    s.reject(p.err);
                }
            } else {
                console.log('没有找到数据回调');
            }
        }

        private _waitings: IndexedObject = {};
    }

    export const jsb = new _JsBridge();

    // 兼容实现promise
    type PromiseInitT<T> = (resolve: (value?: T | PromiseLike<T>) => void, reject: (reason?: any) => void) => void;

    // Reentrant Promise 可以重入的Promise，解决标准Promise的resolve/reject只能调用一次的问题
    export class Promise<T> {

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
        test() {
            return false;
        }
    }
}