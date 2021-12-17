package com.nnt.core;

import android.util.Log

class Logger {
    companion object {
        fun log(msg: String) {
            Log.d("nnt", msg)
        }

        fun warn(msg: String) {
            Log.w("nnt", msg)
        }

        fun fatal(msg: String) {
            Log.e("nnt", msg)
        }
    }
}