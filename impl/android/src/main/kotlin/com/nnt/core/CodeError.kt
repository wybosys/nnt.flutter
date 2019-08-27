package com.nnt.core;

class CodeError(val code: Int, val _msg: String?) {

    val msg: String
        get() {
            if (_msg == null)
                return ""
            return _msg
        }

    override fun toString(): String {
        return "error: ${code} ${_msg}"
    }
}