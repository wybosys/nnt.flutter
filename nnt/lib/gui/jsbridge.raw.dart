part of nnt.gui;
const JS_ENVIRONMENT='''var __extends=this&&this.__extends||function(){var a=function(b,c){return(a=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(a,b){a.__proto__=b}||function(a,b){for(var c in b)b.hasOwnProperty(c)&&(a[c]=b[c])})(b,c)};return function(b,c){function d(){this.constructor=b}a(b,c),b.prototype=null===c?Object.create(c):(d.prototype=c.prototype,new d)}}(),__awaiter=this&&this.__awaiter||function(a,b,c,d){return new(c||(c=Promise))(function(e,f){function g(a){try{i(d.next(a))}catch(b){f(b)}}function h(a){try{i(d["throw"](a))}catch(b){f(b)}}function i(a){a.done?e(a.value):new c(function(b){b(a.value)}).then(g,h)}i((d=d.apply(a,b||[])).next())})},__generator=this&&this.__generator||function(a,b){function c(a){return function(b){return d([a,b])}}function d(c){if(e)throw new TypeError("Generator is already executing.");for(;i;)try{if(e=1,f&&(g=2&c[0]?f["return"]:c[0]?f["throw"]||((g=f["return"])&&g.call(f),0):f.next)&&!(g=g.call(f,c[1])).done)return g;switch(f=0,g&&(c=[2&c[0],g.value]),c[0]){case 0:case 1:g=c;break;case 4:return i.label++,{value:c[1],done:!1};case 5:i.label++,f=c[1],c=[0];continue;case 7:c=i.ops.pop(),i.trys.pop();continue;default:if(g=i.trys,!(g=g.length>0&&g[g.length-1])&&(6===c[0]||2===c[0])){i=0;continue}if(3===c[0]&&(!g||c[1]>g[0]&&c[1]<g[3])){i.label=c[1];break}if(6===c[0]&&i.label<g[1]){i.label=g[1],g=c;break}if(g&&i.label<g[2]){i.label=g[2],i.ops.push(c);break}g[2]&&i.ops.pop(),i.trys.pop();continue}c=b.call(a,i)}catch(d){c=[6,d],f=0}finally{e=g=0}if(5&c[0])throw c[1];return{value:c[0]?c[1]:void 0,done:!0}}var e,f,g,h,i={label:0,sent:function(){if(1&g[0])throw g[1];return g[1]},trys:[],ops:[]};return h={next:c(0),"throw":c(1),"return":c(2)},"function"==typeof Symbol&&(h[Symbol.iterator]=function(){return this}),h},nnt;!function(a){var b;!function(a){var b="nf20w",c=function(){function a(){}return a}();a.JsObject=c;var d=0,e=function(){function a(a,b,c){this.objectId=a,this.action=b,this.params=c}return a.prototype.serialize=function(){var a=JSON.stringify({o:this.objectId,i:this.id,a:this.action,p:this.params?this.params:{}});return a=encodeURI(a),b+"://"+a},a.prototype.unserialize=function(a){a=a.substr(b.length+3),a=decodeURI(a);var c=JSON.parse(a);this.objectId=c.o,this.id=c.i,this.action=c.a,this.params=c.p},a}();a.Message=e;var f={},g=function(){function a(){this._waitings={}}return a.prototype.addJsObj=function(a){return a.objectId?void(f[a.objectId]=a):void alert("添加没有从JsObject继承的对象")},a.prototype.fromApp=function(a){if(0!=a.indexOf(b))return void alert("收到了不支持的数据 "+a);var c=new e(0,null);c.unserialize(a);var d=f[c.objectId];return d?d[c.action]?void d[c.action](c.params):void alert("找不到动作 "+c.action):void alert("找不到对象 "+c.objectId)},a.prototype.toApp=function(a){var b=this;a.id=++d;var c=a.serialize(),e=new h(function(c,d){b._waitings[a.id]={resolve:c,reject:d}});return location.href=c,e},a.prototype.resule=function(a){var b=new e(0,null);b.unserialize(a);var c=this._waitings[b.id];if(c){delete this._waitings[b.id];var d=c.params;d.ok?c.resole(d.ok):c.reject(d.err)}else console.log("没有找到数据回调")},a}();a.jsb=new g;var h=function(){function a(a){var b=this;this._thens=[],this._catchs=[],this._executor=a,setTimeout(function(){b._do()},0)}return a.prototype.then=function(a){return this._thens.push(a),this},a.prototype["catch"]=function(a){return this._catchs.push(a),this},a.prototype._do=function(){var a=this;try{this._executor(function(b){a._thens.forEach(function(a){a(b)})},function(b){a._catchs.length?a._catchs.forEach(function(a){try{a(b)}catch(c){console.log(c)}}):console.log(b)})}catch(b){if(!this._catchs.length)throw b;this._catchs.forEach(function(a){a(b)})}},a}();a.Promise=h;var i=function(a){function b(){return null!==a&&a.apply(this,arguments)||this}return __extends(b,a),b.prototype.test=function(){return __awaiter(this,void 0,void 0,function(){return __generator(this,function(a){return[2,!1]})})},b}(c);a._JsObject=i}(b=a.flutter||(a.flutter={}))}(nnt||(nnt={}));''';
