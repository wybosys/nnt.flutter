package com.nnt.impl

import com.nnt.core.STATUS
import com.nnt.gui.MainActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result

open abstract class Invoker {

    fun call(call: MethodCall, result: Result): Boolean {
        try {
            var ret = invoke(call, result);
            var act = MainActivity.shared
            act.runOnUiThread(fun() {
                ret = ret or run(call, result);
            })
            return ret;
        } catch (err: Exception) {
            result.error(STATUS.EXCEPTION.toString(), err.toString(), null);
        }
        return true
    }

    // 运行在当前线程
    open fun invoke(call: MethodCall, result: Result): Boolean {
        return false;
    }

    // 运行在主线程
    open fun run(call: MethodCall, result: Result): Boolean {
        return false;
    }
}
