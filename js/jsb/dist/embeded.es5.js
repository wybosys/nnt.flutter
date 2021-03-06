/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/embeded/main.ts");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/embeded/main.ts":
/*!*****************************!*\
  !*** ./src/embeded/main.ts ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports) {

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
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var nnt;
(function (nnt) {
    var flutter;
    (function (flutter) {
        var SCHEME = 'nf20w';
        var JsObject = (function () {
            function JsObject() {
            }
            return JsObject;
        }());
        flutter.JsObject = JsObject;
        var MessageMode;
        (function (MessageMode) {
            MessageMode[MessageMode["EMPTY"] = 0] = "EMPTY";
            MessageMode[MessageMode["EVAL"] = 1] = "EVAL";
            MessageMode[MessageMode["VAR"] = 2] = "VAR";
        })(MessageMode = flutter.MessageMode || (flutter.MessageMode = {}));
        var _msgid = 0;
        var Message = (function () {
            function Message(objid, action, params) {
                this.mode = MessageMode.EMPTY;
                this.objectId = objid;
                this.action = action;
                this.params = params;
            }
            Message.prototype.serialize = function () {
                var raw = JSON.stringify({
                    o: this.objectId,
                    i: this.id,
                    a: this.action,
                    p: this.params ? this.params : {},
                    m: this.mode
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
                this.mode = obj.m;
            };
            Message.prototype.apply = function (ok) {
                if (this.mode == MessageMode.EMPTY) {
                    return ok;
                }
                if (this.mode == MessageMode.EVAL) {
                    return eval(ok);
                }
                if (this.mode == MessageMode.VAR) {
                    return ValueByKeyPath(window, ok);
                }
                return ok;
            };
            return Message;
        }());
        flutter.Message = Message;
        var STATUS;
        (function (STATUS) {
            STATUS[STATUS["UNKNOWN"] = -1000] = "UNKNOWN";
            STATUS[STATUS["EXCEPTION"] = -999] = "EXCEPTION";
            STATUS[STATUS["ROUTER_NOT_FOUND"] = -998] = "ROUTER_NOT_FOUND";
            STATUS[STATUS["CONTEXT_LOST"] = -997] = "CONTEXT_LOST";
            STATUS[STATUS["MODEL_ERROR"] = -996] = "MODEL_ERROR";
            STATUS[STATUS["PARAMETER_NOT_MATCH"] = -995] = "PARAMETER_NOT_MATCH";
            STATUS[STATUS["NEED_AUTH"] = -994] = "NEED_AUTH";
            STATUS[STATUS["TYPE_MISMATCH"] = -993] = "TYPE_MISMATCH";
            STATUS[STATUS["FILESYSTEM_FAILED"] = -992] = "FILESYSTEM_FAILED";
            STATUS[STATUS["FILE_NOT_FOUND"] = -991] = "FILE_NOT_FOUND";
            STATUS[STATUS["ARCHITECT_DISMATCH"] = -990] = "ARCHITECT_DISMATCH";
            STATUS[STATUS["SERVER_NOT_FOUND"] = -989] = "SERVER_NOT_FOUND";
            STATUS[STATUS["LENGTH_OVERFLOW"] = -988] = "LENGTH_OVERFLOW";
            STATUS[STATUS["TARGET_NOT_FOUND"] = -987] = "TARGET_NOT_FOUND";
            STATUS[STATUS["PERMISSIO_FAILED"] = -986] = "PERMISSIO_FAILED";
            STATUS[STATUS["WAIT_IMPLEMENTION"] = -985] = "WAIT_IMPLEMENTION";
            STATUS[STATUS["ACTION_NOT_FOUND"] = -984] = "ACTION_NOT_FOUND";
            STATUS[STATUS["TARGET_EXISTS"] = -983] = "TARGET_EXISTS";
            STATUS[STATUS["STATE_FAILED"] = -982] = "STATE_FAILED";
            STATUS[STATUS["UPLOAD_FAILED"] = -981] = "UPLOAD_FAILED";
            STATUS[STATUS["MASK_WORD"] = -980] = "MASK_WORD";
            STATUS[STATUS["SELF_ACTION"] = -979] = "SELF_ACTION";
            STATUS[STATUS["PASS_FAILED"] = -978] = "PASS_FAILED";
            STATUS[STATUS["OVERFLOW"] = -977] = "OVERFLOW";
            STATUS[STATUS["AUTH_EXPIRED"] = -976] = "AUTH_EXPIRED";
            STATUS[STATUS["SIGNATURE_ERROR"] = -975] = "SIGNATURE_ERROR";
            STATUS[STATUS["FORMAT_ERROR"] = -974] = "FORMAT_ERROR";
            STATUS[STATUS["CONFIG_ERROR"] = -973] = "CONFIG_ERROR";
            STATUS[STATUS["PRIVILEGE_ERROR"] = -972] = "PRIVILEGE_ERROR";
            STATUS[STATUS["LIMIT"] = -971] = "LIMIT";
            STATUS[STATUS["PAGED_OVERFLOW"] = -970] = "PAGED_OVERFLOW";
            STATUS[STATUS["NEED_ITEMS"] = -969] = "NEED_ITEMS";
            STATUS[STATUS["IM_CHECK_FAILED"] = -899] = "IM_CHECK_FAILED";
            STATUS[STATUS["IM_NO_RELEATION"] = -898] = "IM_NO_RELEATION";
            STATUS[STATUS["SOCK_WRONG_PORTOCOL"] = -860] = "SOCK_WRONG_PORTOCOL";
            STATUS[STATUS["SOCK_AUTH_TIMEOUT"] = -859] = "SOCK_AUTH_TIMEOUT";
            STATUS[STATUS["SOCK_SERVER_CLOSED"] = -858] = "SOCK_SERVER_CLOSED";
            STATUS[STATUS["THIRD_FAILED"] = -5] = "THIRD_FAILED";
            STATUS[STATUS["MULTIDEVICE"] = -4] = "MULTIDEVICE";
            STATUS[STATUS["HFDENY"] = -3] = "HFDENY";
            STATUS[STATUS["TIMEOUT"] = -2] = "TIMEOUT";
            STATUS[STATUS["FAILED"] = -1] = "FAILED";
            STATUS[STATUS["OK"] = 0] = "OK";
        })(STATUS = flutter.STATUS || (flutter.STATUS = {}));
        var _objects = {};
        var _JsBridge = (function () {
            function _JsBridge() {
                this._waitings = {};
            }
            _JsBridge.prototype.addJsObj = function (obj) {
                if (!obj.objectId) {
                    alert('添加没有从JsObject继承的对象');
                    return;
                }
                _objects[obj.objectId] = obj;
            };
            _JsBridge.prototype.removeJsObj = function (obj) {
                delete _objects[obj.objectId];
            };
            _JsBridge.prototype.fromApp = function (raw) {
                if (raw.indexOf(SCHEME) != 0) {
                    alert("\u6536\u5230\u4E86\u4E0D\u652F\u6301\u7684\u6570\u636E " + raw);
                    return;
                }
                var msg = new Message(0, null);
                msg.unserialize(raw);
                var obj = _objects[msg.objectId];
                if (!obj) {
                    alert("\u627E\u4E0D\u5230\u5BF9\u8C61 " + msg.objectId);
                    return;
                }
                if (!obj[msg.action]) {
                    alert("\u627E\u4E0D\u5230\u52A8\u4F5C " + msg.action);
                    return;
                }
                obj[msg.action](msg.params);
            };
            _JsBridge.prototype.toApp = function (msg) {
                return __awaiter(this, void 0, void 0, function () {
                    var raw, pm, t;
                    var _this = this;
                    return __generator(this, function (_a) {
                        msg.id = ++_msgid;
                        raw = msg.serialize();
                        pm = new Promise(function (resolve, reject) {
                            _this._waitings[msg.id] = { resolve: resolve, reject: reject };
                        });
                        t = document.createElement('iframe');
                        t.src = raw;
                        document.body.appendChild(t);
                        setTimeout(function () {
                            t.remove();
                        }, 0);
                        return [2, pm];
                    });
                });
            };
            _JsBridge.prototype.result = function (raw) {
                var msg = new Message(0, null);
                msg.unserialize(raw);
                var s = this._waitings[msg.id];
                if (s) {
                    delete this._waitings[msg.id];
                    var p = msg.params;
                    if (p.err) {
                        s.reject(new CodeError(p.err.code, p.err.msg));
                    }
                    else {
                        s.resolve(msg.apply(p.ok));
                    }
                }
                else {
                    console.log('没有找到数据回调');
                }
            };
            return _JsBridge;
        }());
        var CodeError = (function () {
            function CodeError(code, msg) {
                this.code = code;
                this.msg = msg;
            }
            CodeError.prototype.toString = function () {
                return "code: " + this.code + " msg: " + this.msg;
            };
            return CodeError;
        }());
        flutter.CodeError = CodeError;
        flutter.jsb = new _JsBridge();
        var _JsObject = (function (_super) {
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
        function LoadStyle(src) {
            return new Promise(function (resolve) {
                var s = document.createElement('link');
                s.rel = 'stylesheet';
                s.href = src;
                document.body.appendChild(s);
                resolve(true);
            });
        }
        flutter.LoadStyle = LoadStyle;
        function LoadScript(src, async) {
            if (async === void 0) { async = true; }
            return new Promise(function (resolve) {
                var s = document.createElement('script');
                if ('async' in s) {
                    s.async = async;
                }
                else {
                    async = false;
                }
                s.src = src;
                if (async) {
                    var suc_1 = function () {
                        this.removeEventListener('load', suc_1, false);
                        this.removeEventListener('error', err_1, false);
                        resolve(true);
                    };
                    var err_1 = function () {
                        this.removeEventListener('load', suc_1, false);
                        this.removeEventListener('error', err_1, false);
                        resolve(false);
                    };
                    s.addEventListener('load', suc_1, false);
                    s.addEventListener('error', err_1, false);
                }
                document.body.appendChild(s);
                if (!async)
                    resolve(true);
            });
        }
        flutter.LoadScript = LoadScript;
        function ValueByKeyPath(obj, kp) {
            var s = kp.split('.');
            s.forEach(function (e) {
                obj = obj[e];
            });
            return obj;
        }
        flutter.ValueByKeyPath = ValueByKeyPath;
        function OpenInstrument() {
            console.log('打开调试面板');
            LoadScript('https://cdn.bootcss.com/vConsole/3.3.2/vconsole.min.js').then(function () {
                new VConsole();
            });
        }
        flutter.OpenInstrument = OpenInstrument;
        flutter.tmp = {};
    })(flutter = nnt.flutter || (nnt.flutter = {}));
})(nnt || (nnt = {}));
window['nnt'] = nnt;


/***/ })

/******/ });
//# sourceMappingURL=embeded.es5.js.map