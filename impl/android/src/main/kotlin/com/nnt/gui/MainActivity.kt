package com.nnt.gui;

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
}