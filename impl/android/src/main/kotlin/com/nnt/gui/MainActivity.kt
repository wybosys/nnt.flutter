package com.nnt.gui;

import android.widget.FrameLayout

open class MainActivity : Activity() {
    companion object {
        private var _shared: MainActivity? = null
        val shared: MainActivity
            get() {
                return _shared as MainActivity
            }
    }

    init {
        _shared = this
    }

    val rootView: FrameLayout get() = findViewById<FrameLayout>(android.R.id.content)
}