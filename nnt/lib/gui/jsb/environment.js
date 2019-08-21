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
var nnt;
(function (nnt) {
    var flutter;
    (function (flutter) {
        // app段匹配的随机数据
        var SCHEME = 'nf20w';
        var JsObject = /** @class */ (function () {
            function JsObject() {
            }
            return JsObject;
        }());
        flutter.JsObject = JsObject;
        var _msgid = 0;
        var Message = /** @class */ (function () {
            function Message(objid, action, params) {
                this.objectId = objid;
                this.action = action;
                this.params = params;
            }
            // 序列化和反序列化
            Message.prototype.serialize = function () {
                var raw = JSON.stringify({
                    o: this.objectId,
                    i: this.id,
                    a: this.action,
                    p: this.params ? this.params : {}
                });
                raw = encodeURI(raw);
                return SCHEME + "://" + raw;
            };
            Message.prototype.unserialize = function (raw) {
                raw = raw.substr(SCHEME.length + 3);
                raw = decodeURI(raw);
                var obj = JSON.parse(raw);
                this.objectId = obj.o;
                this.id = obj.i;
                this.action = obj.a;
                this.params = obj.p;
            };
            return Message;
        }());
        flutter.Message = Message;
        // 用来保存所有从app添加到js的对象
        var _objects = {};
        var _JsBridge = /** @class */ (function () {
            function _JsBridge() {
                this._waitings = {};
            }
            // 添加对象到js中
            _JsBridge.prototype.addJsObj = function (obj) {
                if (!obj.objectId) {
                    alert('添加没有从JsObject继承的对象');
                    return;
                }
                _objects[obj.objectId] = obj;
            };
            // 接受从app中传来的消息
            _JsBridge.prototype.fromApp = function (raw) {
                if (raw.indexOf(SCHEME) != 0) {
                    alert("\u6536\u5230\u4E86\u4E0D\u652F\u6301\u7684\u6570\u636E " + raw);
                    return;
                }
                var msg = new Message(0, null);
                msg.unserialize(raw);
                // 查找池子里的对象
                var obj = _objects[msg.objectId];
                if (!obj) {
                    alert("\u627E\u4E0D\u5230\u5BF9\u8C61 " + msg.objectId);
                    return;
                }
                if (!obj[msg.action]) {
                    alert("\u627E\u4E0D\u5230\u52A8\u4F5C " + msg.action);
                    return;
                }
                // 执行函数
                obj[msg.action](msg.params);
            };
            // 给app发送消息
            _JsBridge.prototype.toApp = function (msg) {
                var _this = this;
                // 分配新的id
                msg.id = ++_msgid;
                var raw = msg.serialize();
                // 监听消息
                var pm = new Promise(function (resolve, reject) {
                    _this._waitings[msg.id] = { resolve: resolve, reject: reject };
                });
                // app通过拦截href来实现
                // console.log('msg: ' + raw);
                location.href = raw;
                return pm;
            };
            // app发送结果
            _JsBridge.prototype.result = function (raw) {
                var msg = new Message(0, null);
                msg.unserialize(raw);
                var s = this._waitings[msg.id];
                if (s) {
                    delete this._waitings[msg.id];
                    var p = msg.params;
                    if (p.ok) {
                        s.resolve(p.ok);
                    }
                    else {
                        s.reject(p.err);
                    }
                }
                else {
                    console.log('没有找到数据回调');
                }
            };
            return _JsBridge;
        }());
        flutter.jsb = new _JsBridge();
        // Reentrant Promise 可以重入的Promise，解决标准Promise的resolve/reject只能调用一次的问题
        var Promise = /** @class */ (function () {
            function Promise(executor) {
                var _this = this;
                this._thens = [];
                this._catchs = [];
                this._executor = executor;
                // 延迟执行，业务会设置then等后处理
                setTimeout(function () {
                    _this._do();
                }, 0);
            }
            Promise.prototype.then = function (func) {
                this._thens.push(func);
                return this;
            };
            Promise.prototype.catch = function (func) {
                this._catchs.push(func);
                return this;
            };
            Promise.prototype._do = function () {
                var _this = this;
                try {
                    this._executor(function (obj) {
                        _this._thens.forEach(function (e) {
                            e(obj);
                        });
                    }, function (reason) {
                        if (_this._catchs.length) {
                            _this._catchs.forEach(function (e) {
                                try {
                                    e(reason);
                                }
                                catch (err) {
                                    console.log(err);
                                }
                            });
                        }
                        else {
                            console.log(reason);
                        }
                    });
                }
                catch (err) {
                    if (this._catchs.length) {
                        this._catchs.forEach(function (e) {
                            e(err);
                        });
                    }
                    else {
                        throw err;
                    }
                }
            };
            return Promise;
        }());
        flutter.Promise = Promise;
        // 为了使ts生成对应的工具头
        var _JsObject = /** @class */ (function (_super) {
            __extends(_JsObject, _super);
            function _JsObject() {
                return _super !== null && _super.apply(this, arguments) || this;
            }
            _JsObject.prototype.test = function () {
                return false;
            };
            return _JsObject;
        }(JsObject));
        flutter._JsObject = _JsObject;
    })(flutter = nnt.flutter || (nnt.flutter = {}));
})(nnt || (nnt = {}));
