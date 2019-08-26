package com.nnt.gui;

import android.content.Context
import android.os.PowerManager
import io.flutter.app.FlutterActivity

open class Activity : FlutterActivity() {

    val _powermgr: PowerManager
        get() {
            return this.getSystemService(Context.POWER_SERVICE) as PowerManager
        }
    var _wakelck: PowerManager.WakeLock? = null

    // 保持常亮
    fun alwaysLight(turnon: Boolean) {
        if (turnon == (_wakelck != null)) {
            // 当前状态和设置的一样
            return
        }

        if (turnon) {
            _wakelck = _powermgr.newWakeLock(PowerManager.FULL_WAKE_LOCK, "::nnt::activity::wakelock") as PowerManager.WakeLock
        } else {
            if (_wakelck?.isHeld() == true)
                _wakelck?.release()
            _wakelck = null
        }
    }

    override fun onResume() {
        super.onResume()
        _wakelck?.acquire();
    }

    override fun onPause() {
        super.onPause()
        _wakelck?.release();
    }
}