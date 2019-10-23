package com.nnt.impl;

import com.nnt.core.CodeError
import com.nnt.core.Logger
import com.nnt.gui.Activity
import com.nnt.gui.MainActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

open abstract class Method(name: String, ui: Boolean = true) {

    // 方法名
    val name = name

    // 主线程
    val ui = ui

    // 绑定执行器
    fun bindResult(result: MethodChannel.Result) {
        _result = result
    }

    // 运行成功
    fun success(obj: Any) {
        _result?.success(obj)
        _result = null
    }

    // 运行失败
    fun error(err: CodeError) {
        err.result(_result)
        _result = null
    }

    private var _result: MethodChannel.Result? = null
    val result: MethodChannel.Result get() = _result as MethodChannel.Result

    // 实现调用
    abstract fun invoke(call: MethodCall)
}

private fun Invoke(mth: Method, call: MethodCall) {
    if (mth.ui) {
        val act = MainActivity.shared
        act.runOnUiThread(fun() {
            mth.invoke(call)
        })
    } else {
        mth.invoke(call)
    }
}

open class Channel(registrar: Registrar, channname: String) : MethodChannel.MethodCallHandler {

    private val _methods: MutableMap<String, Method> = mutableMapOf()

    // app启动时注册channel用的全局唯一对象
    private val _registrar: Registrar = registrar

    init {
        // 初始化信道
        val t = MethodChannel(registrar.messenger(), channname)
        t.setMethodCallHandler(this)

        // 实现默认的处理
        register(object : Method("keepAlwaysLight") {
            override fun invoke(call: MethodCall) {
                activity.alwaysLight(call.argument<Boolean>("turnon") == true)
                result.success(true)
            }
        })
    }

    // 绑定的全局上下文
    val activity: Activity
        get() {
            return _registrar.activity() as Activity
        }

    fun method(method: String): Method? {
        return _methods[method]
    }

    fun register(mth: Method) {
        _methods[mth.name] = mth
    }

    fun unregister(name: String) {
        _methods.remove(name)
    }

    // 实现方法回调
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Logger.log("收到原生请求 ${call.method}")

        val mth = _methods[call.method]
        if (mth != null) {
            mth.bindResult(result)
            Invoke(mth, call)
        } else {
            result.notImplemented()
        }
    }
}
