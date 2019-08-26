package com.nnt.impl;

import com.nnt.core.Logger
import com.nnt.gui.Activity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

open class Channel(registrar: Registrar, channname: String) : MethodChannel.MethodCallHandler {

    val _registrar: Registrar = registrar

    init {
        val t = MethodChannel(registrar.messenger(), channname)
        t.setMethodCallHandler(this)
    }

    val activity: Activity
        get() {
            return _registrar.activity() as Activity
        }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Logger.log("收到原生请求 ${call.method}")

        // 实现渠道无关的通用调用
        when (call.method) {
            "keepAlwaysLight" -> {
                activity.alwaysLight(call.argument<Boolean>("turnon") == true)
                result.success(true)
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
