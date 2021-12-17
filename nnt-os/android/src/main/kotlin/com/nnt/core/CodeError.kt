package com.nnt.core;

import io.flutter.plugin.common.MethodChannel.Result

class CodeError(val code: Int, val _msg: String?) : Exception(_msg) {

    val msg: String
        get() {
            if (message == null)
                return ""
            return message as String
        }

    override fun toString(): String {
        return "error: $code $_msg"
    }

    fun result(res: Result?) {
        res?.error(code.toString(), msg, null)
    }
}