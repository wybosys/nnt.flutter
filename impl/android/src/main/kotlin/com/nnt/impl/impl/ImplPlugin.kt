package com.nnt.impl.impl

import com.nnt.core.Device
import com.nnt.core.Udid
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class ImplPlugin : MethodCallHandler {

    companion object {
        var _Registrar: Registrar? = null

        val Registrar: Registrar
            get() {
                return _Registrar as Registrar
            }

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            _Registrar = registrar;

            val channel = MethodChannel(registrar.messenger(), "impl")
            channel.setMethodCallHandler(ImplPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }
            "getUdid" -> {
                result.success(Udid.GetCurrent(Registrar.context()));
            }
            "getMAC" -> {
                result.success(Device.GetMacAddress(Registrar.context()))
            }
            "getIMEI" -> {
                result.success(Device.GetIMEI(Registrar.context()))
            }
            "getANDROIDID" -> {
                result.success(Device.GetAndroidId(Registrar.context()))
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}
