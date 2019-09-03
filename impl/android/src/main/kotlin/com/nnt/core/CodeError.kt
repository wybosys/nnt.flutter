package com.nnt.core;

class CodeError(val code: Int, val _msg: String?) : Throwable(_msg) {

    val msg: String
        get() {
            if (message == null)
                return ""
            return message as String
        }

    override fun toString(): String {
        return "error: $code $_msg"
    }
}