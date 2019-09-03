package com.nnt.gui;

import com.nnt.core.Config
import io.flutter.app.FlutterApplication

open class Application : FlutterApplication() {
    companion object {
        private var _shared: Application? = null
        val shared: Application
            get() {
                return _shared as Application
            }
    }

    init {
        _shared = this

        // 设置基本配置参数
        Config.shared.override(mapOf("DEBUG" to false))
    }
}