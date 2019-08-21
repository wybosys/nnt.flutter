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
        var Message = /** @class */ (function () {
            function Message() {
            }
            // 序列化和反序列化
            Message.prototype.serialize = function () {
                var raw = JSON.stringify({
                    o: this.objectId,
                    a: this.action,
                    p: this.params
                });
                raw = encodeURI(raw);
                return SCHEME + "://" + raw;
            };
            Message.prototype.unserialize = function (raw) {
                raw = raw.substr(SCHEME.length + 3);
                raw = decodeURI(raw);
                var obj = JSON.parse(raw);
                this.objectId = obj.o;
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
                var msg = new Message();
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
                var raw = msg.serialize();
                // app通过拦截href来实现
                location.href = raw;
            };
            return _JsBridge;
        }());
        flutter.jsb = new _JsBridge();
    })(flutter = nnt.flutter || (nnt.flutter = {}));
})(nnt || (nnt = {}));
