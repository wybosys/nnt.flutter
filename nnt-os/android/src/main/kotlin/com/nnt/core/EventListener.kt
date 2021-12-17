package com.nnt.core

import com.nnt.gui.MainActivity

interface EventCallback {
    fun invoke();
}

class EventSlot(cb: EventCallback) {
    val cb: EventCallback = cb
    var mainUi = false
}

open class EventListener {

    fun add(event: String, cb: EventCallback, mainUi: Boolean = false) {
        if (!_listeners.containsKey(event)) {
            _listeners.set(event, mutableListOf())
        }

        val slot = EventSlot(cb)
        slot.mainUi = mainUi
        _listeners[event]!!.add(slot)
    }

    fun emit(event: String) {
        if (!_listeners.containsKey(event))
            return
        _listeners[event]!!.forEach {
            if (it.mainUi) {
                var act = MainActivity.shared
                act.runOnUiThread(fun() {
                    it.cb.invoke()
                })
            } else {
                it.cb.invoke()
            }
        }
    }

    private var _listeners = mutableMapOf<String, MutableList<EventSlot>>()
}