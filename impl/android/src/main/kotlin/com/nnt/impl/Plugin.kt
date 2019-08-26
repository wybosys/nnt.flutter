package com.nnt.impl;

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

open class Plugin : MethodChannel.MethodCallHandler {
    companion object {
        var Registrar: PluginRegistry.Registrar? = null

        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            // 绑定, 用于实现具体渠道时构造methodcall
            Registrar = registrar
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        // 实现渠道无关的通用调用
        when (call.method) {
            "keepAlwaysLight" -> {
                // this._keepAlwaysLight(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
